class TopsController < ApplicationController
  skip_before_action :authenticate_user!
  def index  
    @items = Item.limit(5).order('created_at DESC')
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
  def new

  end
end
