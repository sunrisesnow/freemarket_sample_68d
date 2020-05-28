class UsersController < ApplicationController
  before_action :set_item_search_query

  def show
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end

end
