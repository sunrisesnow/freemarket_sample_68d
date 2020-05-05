class ItemsController < ApplicationController
  def index
    @items = Item.all
    @images = Image.all
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
  
  # def done
  #   @item_buyer = Item.find(params[:id])
  #   @item_buyer.update(buyer_id: current_user.id)
  # end
end
