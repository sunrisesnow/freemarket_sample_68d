class ItemsController < ApplicationController
  def index
    render "/items/index"
    @items = Item.all
    @images = Image.all
    @categories = Category.all
  end
end
