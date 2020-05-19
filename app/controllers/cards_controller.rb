class CardsController < ApplicationController
  require "payjp"
  before_action :set_category_brand
  before_action :set_card
  before_action :set_payjp_api, except: [:new]
  
  def index
    if @card.present?
      customer    = Payjp::Customer.retrieve(@card.payjp_id)
      @card_info  = customer.cards.retrieve(customer.default_card)
      @card_brand = @card_info.brand
      @exp_month  = @card_info.exp_month.to_s
      @exp_year   = @card_info.exp_year.to_s.slice(2,3) 
    else
      render :new
    end
  end

  def new
    redirect_to cards_path if @card.present?
  end

  def create
    render :new if params[:payjpToken].blank?
    customer = Payjp::Customer.create(card: params[:payjpToken])
    @card    = Card.new(user_id: current_user.id, payjp_id: customer.id)
    @card.save! ? (redirect_to cards_path) : (render :new)
  end

  def destroy     
    customer = Payjp::Customer.retrieve(@card.payjp_id)
    customer.delete 
    redirect_to cards_path if @card.destroy
  end

  def buy
    @item = Item.find(params[:id])
    if @item.buyer_id.present? 
      redirect_to item_path(@item)
    elsif @card.blank?
      render :new
    else
      Payjp::Charge.create(
        amount: @item.price,
        customer: @card.payjp_id,
        currency: 'jpy'
      )
      @item.update(buyer_id: current_user.id) ? (redirect_to item_path(@item)) : (redirect_to root_path)
    end
  end

  def check
    @item = Item.find(params[:id])
    customer    = Payjp::Customer.retrieve(@card.payjp_id)
      @card_info  = customer.cards.retrieve(customer.default_card)
      @card_brand = @card_info.brand
      @exp_month  = @card_info.exp_month.to_s
      @exp_year   = @card_info.exp_year.to_s.slice(2,3) 
  end

  private
  def set_category_brand
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def set_payjp_api
    Payjp.api_key =  Rails.application.credentials.payjp[:payjp_private_key]
  end
end
