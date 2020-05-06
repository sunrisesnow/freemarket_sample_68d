class CategoriesController < ApplicationController
  before_action :set_category_brand
  before_action :find_category, except: [:index]
  def index
    
  end

  def parent
    #親要素の子要素代入
    children = @category.children
    grandchildren = []
    # ancestryに(親要素id/子要素id)が入っている要素全て取得
    children.each do |child|
      grandchildren << Category.where(ancestry: "#{@category.id}/#{child.id}")
    end
    @items = []
    # grandchildrenは（１子要素の１孫要素、２子要素の２孫要素）という多重配列なのでeachを二回重ねることで親要素の全ての孫要素のidをwhereメソッドに渡しています。
    grandchildren.each do |grandchild|
      grandchild.each do |id|
        @items += Item.where(category_id: id)
      end
    end
  end

  def child
    #子要素の孫要素代入
    grandchildren = @category.children
    @items = []
    #子要素の孫要素という一つの配列なのでeachは一度で孫要素のid取得
    grandchildren.each do |grandchild|
      @items += Item.where(category_id: grandchild.id)
    end
  end

  def grandchild
    @items = Item.where(category_id: params[:id])
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def set_category_brand
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
end
