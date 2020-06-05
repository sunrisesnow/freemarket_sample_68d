class TradingController < ApplicationController
  include TradingHelper
  before_action :set_category_brand
  before_action :set_trading_item
  before_action :set_item_search_query
  before_action :set_trading_item_users
  before_action :set_new_message
  before_action :item_user?
  
  def show
    @messages = @item.messages.includes(:from).asc
    trading_item_fee(@item)
  end

  def update
    case current_user.id
    when @saler_user.id
      case @item.trading_status_id
      when 1
        redirect_to root_path unless @item.update!(trading_status_id: 2) 
      when 3
        if @item.update!(trading_status_id: 5)
          sales_prices(@saler_user, @item)
          gives_point(@buyer_user, @item)
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    when @buyer_user.id
      case @item.trading_status_id
      when 2 
        redirect_to root_path unless @item.update(trading_status_id: 3)
      else
        redirect_to root_path
      end
    end
  end

  def cancel
    case current_user.id
    when @saler_user.id
      case @item.trading_status_id
      when 1
        if @item.update(trading_status_id: 7)
          Message.create(
            from_id: @saler_user.id, 
            to_id:   @buyer_user.id, 
            room_id: @item.id, 
            message: "#{@saler_user.nickname}さんから取引キャンセル願いがありました"
          )
        else
          redirect_to root_path
        end
      when 6
        if @item.update(trading_status_id: 8)
          Message.create(
            from_id: @saler_user.id, 
            to_id:   @buyer_user.id, 
            room_id: @item.id, 
            message: "#{@saler_user.nickname}さんが取引キャンセルを承認しました"
          )
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    when @buyer_user.id
      case @item.trading_status_id
      when 1
        if @item.update(trading_status_id: 6)
          Message.create(
            from_id: @buyer_user.id, 
            to_id:   @saler_user.id, 
            room_id: @item.id, 
            message: "#{@buyer_user.nickname}さんから取引キャンセル願いがありました"
          )
        else
          redirect_to root_path
        end
      when 7
        if @item.update(trading_status_id: 8)
          Message.create(
            from_id: @buyer_user.id, 
            to_id:   @saler_user.id, 
            room_id: @item.id, 
            message: "#{@buyer_user.nickname}さんが取引キャンセルを承認しました"
          )
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
    @messages = @item.messages.includes(:from).asc
  end

  def relist
    if current_user.id == @saler_user.id && @item.trading_status_id == 8
      @item.update(trading_status_id: 1, buyer_id: nil) ? (redirect_to item_path(@item)) : (redirect_to root_path)
    else
      redirect_to root_path
    end
  end

  private

  def set_trading_item_users
    trading_item_users(@item)
  end

  def set_new_message
    @message = Message.new
  end

  def sales_prices(saler_user, item)
    trading_item_fee(item)
    sales_price = SalesPrice.user(saler_user.id)
    if sales_price.present?
      sum_price = sales_price.price + @sales_profit
      redirect_to root_path unless sales_price.update(price: sum_price) 
    else
      redirect_to root_path unless SalesPrice.create(user_id: saler_user.id, price: @sales_profit)
    end
  end

  def gives_point(buyer_user, item)
    trading_item_fee(item)
    point = Point.user(buyer_user.id)
    if point.present?
      sum_point = point.point + @sales_commission
      redirect_to root_path unless point.update(point: sum_point) 
    else
      redirect_to root_path unless Point.create(user_id: buyer_user.id, point: @sales_commission)
    end
  end
end
