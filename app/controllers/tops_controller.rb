class TopsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_item_search_query
  before_action :set_category_brand,  only: [:index]
  
  def index  
    @items = Item.includes(:images).limit(5).order('created_at DESC').where.not(trading_status_id: 4)
  end
  
  def new
  end
end
