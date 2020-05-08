class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_item, except: [:new, :create, :index, :category_children, :category_grandchildren]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
    @parents = []
    Category.where(ancestry: nil).each do |parent|
      unless parent.name == "カテゴリー一覧"
        @parents << parent.name
      end
    end
  end

  def category_children
    @children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def category_grandchildren
    @grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to items_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to items_path
    else
      render :edit
    end
  end

  def show
    @images = @item.images
    @categories = Category.all
  end 

  def get_category_children
    @category_children = Category.find(params[:productcategory]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:productcategory]).children
  end
end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name, 
      :explanation,
      :category_id,
      :status_id,
      :delivery_charge_flag,
      :prefecture_id,
      :delivery_date_id,
      :price, 
      images_attributes: [
        :id,
        :image
      ]
    ).merge(saler_id: current_user.id)
  end
