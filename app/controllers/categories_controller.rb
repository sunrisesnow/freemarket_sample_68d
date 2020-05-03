class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  def index
    @parents = Category.where(ancestry: nil).where.not(name: "カテゴリー一覧")
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end

  def show
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
    @item = Item.find_by(category_id: @category.id)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

end
