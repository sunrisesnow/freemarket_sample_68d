class TradingController < ApplicationController
  before_action :set_category_brand
  before_action :set_trading_item
  before_action :set_item_search_query
  before_action :item_user?
  
  def show
    
  end

  def update
    if @item.trading_status_id == 1 && current_user.id == @item.saler_id
      @item.update!(trading_status_id: 2) ? (redirect_to item_trading_path(@item, current_user)) : (redirect_to root_path)
    elsif @item.trading_status_id == 2  && current_user.id == @item.buyer_id
      @item.update!(trading_status_id: 3) ? (redirect_to item_trading_path(@item, current_user)) : (redirect_to root_path)
    elsif @item.trading_status_id == 3  && current_user.id == @item.saler_id
      @item.update!(trading_status_id: 5) ? (redirect_to item_trading_path(@item, current_user)) : (redirect_to root_path)
    else
      redirect_to root_path
    end
  end

  private

  def set_trading_item
    @item = Item.find(params[:item_id])
  end

  def item_user?
    redirect_to root_path unless @item.saler_id == current_user.id || @item.buyer_id == current_user.id
  end
end
