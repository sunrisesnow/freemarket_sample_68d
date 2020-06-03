class UsersController < ApplicationController
  before_action :set_item_search_query
  before_action :set_category_brand
  
  def index
  end

  def show
  end

  def draft
    @items = Item.includes(:images).where(trading_status_id: 4).where(saler_id: current_user.id).page(params[:page]).per(15)
  end

  def exhibition
    @items = Item.includes(:images).where(saler_id: current_user.id).where(buyer_id: nil).where(trading_status_id: 1).page(params[:page]).per(15)
  end

  def exhibition_trading
    @items = Item.includes(:images).where(saler_id: current_user.id).where.not(buyer_id: nil).where.not(trading_status_id: 4..5).page(params[:page]).per(15)
  end

  def exhibition_completed
    @items = Item.includes(:images).where(saler_id: current_user.id).where(trading_status_id: 5).page(params[:page]).per(15)
  end

  def bought
    @items = Item.includes(:images).where(buyer_id: current_user.id).where.not(trading_status_id: 4..5).page(params[:page]).per(15)
  end

  def bought_completed
    @items = Item.includes(:images).where(buyer_id: current_user.id).where(trading_status_id: 5).page(params[:page]).per(15)
  end

end
