class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
end
