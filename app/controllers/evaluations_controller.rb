class EvaluationsController < ApplicationController
  include TradingHelper
  before_action :set_categories
  before_action :set_trading_item, only: %i[create]
  before_action :item_present?, only: %i[create]
  before_action :set_item_search_query
  before_action :set_trading_item_users, only: %i[create]
  before_action :set_new_message, only: %i[create]
  before_action :item_user?, only: %i[create]

  def index
    @evaluations = current_user.evaluations.eager_load(saler: :account,buyer: :account).page(params[:page]).per(9)
  end

  def create
    @evaluation = Evaluation.new
    redirect_to root_path unless Evaluation.create!(params_evaluation)
    if @item.trading_status_id == 2
      redirect_to root_path unless @item.update(trading_status_id: 3)
      return
    elsif @item.trading_status_id == 3
      if @item.update(trading_status_id: 5)
        sales_prices(@saler_user, @item)
        gives_point(@buyer_user, @item)
      else
        redirect_to root_path
      end
    end
  end

  private

  def params_evaluation
    if @item.trading_status_id == 2
      params.require(:evaluation).permit(
        :comment,
        :evaluation).merge(user_id: @saler_user.id, saler_id: @saler_user.id, buyer_id: @buyer_user.id)
    elsif @item.trading_status_id == 3
      params.require(:evaluation).permit(
        :comment,
        :evaluation).merge(user_id: @buyer_user.id, saler_id: @saler_user.id, buyer_id: @buyer_user.id)
    end
  end
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
