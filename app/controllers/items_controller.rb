class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_category_brand,  except: [:destroy]

  def index
    @items = Item.includes(:images).order('created_at DESC').where.not(trading_status_id: 4)
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
      @item.trading_status_id == 4 ? (redirect_to draft_items_path) : (redirect_to items_path)
    else
      render :new
    end
  end

  def edit
    redirect_to root_path unless current_user.id == @item.saler_id
    @parents = Category.where(ancestry: nil).where.not(name: "カテゴリー一覧").pluck(:name)
    @category_child_array = @item.category.parent.siblings
    @category_grandchild_array = @item.category.siblings
  end

  def update
    if @item.update!(item_params)
      if add_item_images = params[:item][:image]
        add_item_images.each do|image|
          @item.images.create(image: image, item_id: @item.id) if @item.images.count <= 10
        end
      end
      @item.trading_status_id == 4 ? (redirect_to draft_items_path) : (redirect_to item_path(@item))
    else
      render :edit
    end
  end

  def show
    @user = User.find_by(id: @item.saler_id)
    redirect_to root_path if @item == nil || @item.trading_status_id != 1
  end 

  def destroy
    redirect_to root_path  unless current_user.id == @item.saler_id
    @item.destroy && @item.trading_status_id == 4? (redirect_to draft_items_path) : (redirect_to exhibition_items_path) 
  end

  def draft
    @items = Item.includes(:images).where(trading_status_id: 4).where(saler_id: current_user.id).page(params[:page]).per(15)
  end

  def exhibition
    @items = Item.includes(:images).where(saler_id: current_user.id).where(buyer_id: nil).where(trading_status_id: 1).page(params[:page]).per(15)
  end

  def exhibition_trading
    @items = Item.includes(:images).where(saler_id: current_user.id).where.not(buyer_id: nil).page(params[:page]).per(15)
  end

  def bought
    @items = Item.includes(:images).where(buyer_id: current_user.id).page(params[:page]).per(15)
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
