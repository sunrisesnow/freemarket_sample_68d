class UsersController < ApplicationController

  before_action :set_category_brand

  def show
  end

  def index
  end

  private

  def set_category_brand
    @parents = Category.where(ancestry: nil)
    @brands  =  ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
end
