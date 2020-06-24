class LikesController < ApplicationController
  before_action :set_item_search_query
  before_action :set_item, except: [:index]
  before_action :set_categories,  only: [:index]
  before_action :move_show_item, except: [:index]

  def index
    like_ids = Like.users(params[:user_id]).pluck(:id)
    @items = Item.eager_load(:images).joins(:likes).where(likes: {id: like_ids}).page(params[:page]).per(12)
  end

  def create
    like = Like.create(user_id: current_user.id, item_id: params[:item_id])&.create_notification_by(current_user)
  end

  def destroy
    like = Like.find(params[:id])
    current_user.id == like.user_id ? ( like.destroy&.destroy_notification_by(current_user, @item.id)) : (redirect_to root_path)
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_show_item
    redirect_to item_path(@item) if current_user.id == @item.saler_id
  end
end
