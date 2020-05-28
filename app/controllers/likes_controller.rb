class LikesController < ApplicationController
  before_action :set_item, only: [:create, :destroy]

  def index
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
    items = []
    likes = Like.where(user_id: params[:user_id])
    if likes.present?
      likes.each { |like| items << Item.find(like.item_id)}
    end
    @items = Kaminari.paginate_array(items).page(params[:page]).per(15)
  end

  def create
    like = Like.create(user_id: current_user.id, item_id: params[:item_id])
  end

  def destroy
    like = Like.find(params[:id])
    current_user.id == like.user_id ? ( like.destroy) : (redirect_to root_path)
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
