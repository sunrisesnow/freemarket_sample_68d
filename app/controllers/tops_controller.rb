class TopsController < ApplicationController
  skip_before_action :authenticate_user!
  def index  
    @items = Item.includes(:images).limit(5).order('created_at DESC').where.not(trading_status_id: 4)
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
  def new

  end
end
