class ItemsController < ApplicationController
  before_action :set_item, except: [:new, :create, :index, :category_children, :category_grandchildren]
  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
    @parents_array = 
    @parents = ["選択してください"]
    Category.where(ancestry: nil).where.not(name: "カテゴリー一覧").each do |parent|
      @parents << parent.name
    end
  end

  def category_children
    @children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def category_grandchildren
    @grandchildren = Category.find_by(name: "#{params[:child_name]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
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

  private
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
    )
    # userの登録機能実装が完了したら生かす
    # .merge(user_id: current_user.id)
  end
end
