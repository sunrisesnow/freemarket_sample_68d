class CategoriesController < ApplicationController
  before_action :set_item_search_query
  before_action :set_categories
  before_action :find_category, except: [:index]
  skip_before_action :authenticate_user!
  
  def index
    
  end

  def show
    @items = Item.including.where(category_id: @category.subtree_ids).trading_not.page(params[:page]).per(30)
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end
end
