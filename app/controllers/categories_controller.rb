class CategoriesController < ApplicationController
  
  before_action :set_category_brand
  before_action :find_category, except: [:index]
  skip_before_action :authenticate_user!
  
  def index
    
  end

  def parent
    grandchildren_id = @category.indirect_ids 
    find_category_item(grandchildren_id)
  end

  def child
    grandchildren_id = @category.child_ids
    find_category_item(grandchildren_id)
  end

  def grandchild
    @items = []
    category_item = Item.includes(:images).where(category_id: params[:id])
    category_present(category_item)
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def set_category_brand
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
  
  def category_present(category_item)
    if category_item.present?
      @items += category_item
    end
  end

  def find_category_item(grandchildren_id)
    @items = []
    category_item = []
    grandchildren_id.each do |grandchild_id|
      category_item = Item.includes(:images).where(category_id: grandchild_id)
      category_present(category_item)
    end
  end
end
