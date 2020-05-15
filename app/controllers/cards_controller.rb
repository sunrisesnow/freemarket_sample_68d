class CardsController < ApplicationController
  require "payjp"
  before_action :set_category_brand
  before_action :set_card
  before_action :set_payjp_api, except: [:new]
  
  def index
    if @card.present?
      # カードがある場合
      # customerにはretrieveメソッドの引数に指定したidに一致する顧客情報を取得。
      customer = Payjp::Customer.retrieve(@card.payjp_id)
      # カード情報はdefault_cardメソッドを使うことで取得できる。
      @card_info = customer.cards.retrieve(customer.default_card)
      # カードの親会社名を取得
      @card_brand = @card_info.brand
      # クレジットカードの有効期限を取得
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3) 
    end
  end

  def new
    # cardがすでに登録済みの場合、indexのページに戻します。
    @card = Card.find_by(user_id: current_user.id)
    redirect_to action: "index" if @card.present?    
  end

  def create
    # jsで作成したpayjpTokenがちゃんと入っているか？
    if params['payjpToken'].blank?
      render :new
    else
      # トークンがちゃんとあれば進めて、PAY.JPに登録されるユーザーを作成します。
      customer = Payjp::Customer.create(
        description: 'test',#ここの記述はなくてもよし
        email: current_user.email,#ここの記述はなくてもよし
        card: params['payjpToken'],#トークンだけ送るだけでも可能
        metadata: {user_id: current_user.id},#ここの記述はなくてもよし
      )

      # PAY.JPのユーザーが作成できたので、Cardモデルを登録します。
      @card = Card.new(user_id: current_user.id, payjp_id: customer.id)
      if @card.save!
        redirect_to action: "index"
      else
        render :new
      end
    end
  end

  def destroy     
    # retrieveメソッドを使うことで引数にしていされているidと一致する顧客情報を取得
    customer = Payjp::Customer.retrieve(@card.payjp_id)
    # PAY.JPの顧客情報を削除
    customer.delete 
    # App上でもクレジットカードを削除
    redirect_to action: "index" if @card.destroy 
  end

  def buy
    @item = Item.find(params[:id])
    # すでに購入されていないか？
    if @item.buyer_id.present? 
      render root_path
    elsif @card.blank?
      # カード情報がなければ、買えないから戻す
      render :new
    else
      # 購入者もいないし、クレジットカードもあるし、決済処理に移行
      # 請求を発行
      Payjp::Charge.create(
        amount: @item.price,
        customer: @card.payjp_id,
        currency: 'jpy',
      )
      # 売り切れなので、Itemの情報をアップデートして売り切れにします。
      if @item.update(buyer_id: current_user.id)
        redirect_to controller: 'items', action: 'show', id: @item.id 
      end
    end
  end

  private
  def set_category_brand
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id) if Card.find_by(user_id: current_user.id).present?
  end

  def set_payjp_api
    Payjp.api_key =  Rails.application.credentials.payjp[:payjp_private_key]
  end
end
