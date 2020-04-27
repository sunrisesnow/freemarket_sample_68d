class ItemsController < ApplicationController
  before_action :set_item, except: [:new, :create, :index]
  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, images_attributes: [:image])
  end
end
