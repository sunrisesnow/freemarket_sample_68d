class ItemController < ApplicationController
  before_action :set_item, only: [:show]
 def index
 end

 def new
 end

 def create
 end

 def edit
 end

 def destroy
 end

 def show
  @images = @items.images
  @categories = Category.all
 end


  private

  def set_item
    @items = Item.find(params[:id])
  end
end
