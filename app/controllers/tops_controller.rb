class TopsController < ApplicationController
  before_action :authenticate_user!, only: [:set_notice]
  before_action :set_item_search_query
  before_action :set_category_brand,  only: [:index]
  before_action :set_notice

  
  def index  
    @items = Item.including.limit(5).desc.trading_not
  end
  
  def new
  end

  private
  def set_notice
    if current_user.present?
    @notifications = current_user.passive_notifications
    end
  end
end