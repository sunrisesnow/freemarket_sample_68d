class TopsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_item_search_query

  def index  
    @items = Item.includes(:images).limit(5).order('created_at DESC')
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
  def new

  end
end
