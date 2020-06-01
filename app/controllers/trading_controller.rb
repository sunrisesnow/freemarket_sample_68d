class TradingController < ApplicationController
  include TradingHelper
  before_action :set_category_brand
  before_action :set_trading_item
  before_action :set_item_search_query
  before_action :set_trading_item_users
  before_action :set_new_message
  before_action :item_user?
  
  def show
    @messages = @item.messages.includes(:from).order('created_at ASC')
    trading_item_fee(@item)
  end

  def update
    case current_user.id
    when @item.saler_id
      case @item.trading_status_id
      when 1
        redirect_to root_path unless @item.update!(trading_status_id: 2) 
      when 3
        redirect_to root_path unless @item.update!(trading_status_id: 5)
      else
        redirect_to root_path
      end
    when @item.buyer_id
      case @item.trading_status_id
      when 2 
        redirect_to root_path unless @item.update(trading_status_id: 3)
      else
        redirect_to root_path
      end
    end
  end

  private

  def set_trading_item_users
    trading_item_users(@item)
  end

  def set_new_message
    @message  = Message.new
  end
end
