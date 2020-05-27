class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_category_brand, only: [:index, :new, :create, :show, :edit, :update]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
    @parents = Category.where(ancestry: nil).where.not(name: "カテゴリー一覧").pluck(:name)
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
      params[:item_images][:image].each do |image|
        @item.images.create(image: image, item_id: @item.id)
      end
    else
      render :new
    end
  end

  def edit
    @item.images.all
    @parents = []
    Category.where(ancestry: nil).each do |parent|
      unless parent.name == "カテゴリー一覧"
        @parents << parent.name
      end
    end
    @category_child_array = @item.category.parent.parent.children
    @category_grandchild_array = @item.category.parent.children
  end

  def update
    @parents = []
    Category.where(ancestry: nil).each do |parent|
      unless parent.name == "カテゴリー一覧"
        @parents << parent.name
      end
    end
    @category_child_array = @item.category.parent.parent.children
    @category_grandchild_array = @item.category.parent.children
    if @item.update!(item_params)
      if add_item_images = params[:item][:image]
        add_item_images.each do|image|
          @item.images.create(image: image, item_id: @item.id) if @item.images.count <= 10
        end
      end
      redirect_to item_path
    else
      render :edit
    end
  end

  def show
    @user = User.find_by(id: @item.saler_id)
    redirect_to root_path if @item == nil
  end 

  def destroy
    redirect_to root_path  unless current_user.id == @item.saler_id
    @item.destroy ? (redirect_to root_path) : (redirect_to item_path(@item)) 
  end

  def search
    @q = Item.search(search_params)
    @items = @q.result(distinct: true)
  end

  private

  def set_category_brand
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end

  def set_item
    @item = Item.find_by_id(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name, 
      :explanation,
      :category_id,
      :status_id,
      :delivery_charge_flag,
      :delivery_method_id,
      :prefecture_id,
      :delivery_date_id,
      :price, 
      :trading_status_id,
      images_attributes: [
        :id,
        :image,
        :_destroy
      ]
    ).merge(saler_id: current_user.id)
  end
end
