class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, except: [:new, :edit, :create, :update, :destroy]
  before_action :set_item_search_query, expect: [:search]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_categories,  except: [:destroy]
  
  def index
  end

  def new
    @item = Item.new
    @item.images.new
    @parents = Category.ancestries(nil).name_not("カテゴリー一覧")
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
      redirect_to draft_items_path if @item.trading_status_id == 4
    else
      render :new
    end
  end

  def edit
    redirect_to root_path unless current_user.id == @item.saler_id
    @parents = Category.ancestries(nil).name_not("カテゴリー一覧")
    @category_child_array = @item.category.parent.siblings
    @category_grandchild_array = @item.category.siblings
    @delivery_methods = DeliveryMethod.find_all_by_flag(@item.delivery_charge_flag.to_s)
  end

  def update
    if @item.update!(item_params)
      if add_item_images = params[:item][:image]
        add_item_images.each do|image|
          @item.images.create(image: image, item_id: @item.id) if @item.images.count <= 10
        end
      end
      @item.trading_status_id == 4 ? (redirect_to draft_users_path) : (redirect_to item_path(@item))
    else
      render :edit
    end
  end

  def show
    if @item == nil || @item.trading_status_id == 4
      redirect_to root_path 
    else
      @user = User.find_by(id: @item.saler_id)
    end
  end 

  def destroy
    redirect_to root_path  unless current_user.id == @item.saler_id
    if @item.trading_status_id == 5
      @item.destroy ? (redirect_to exhibition_completed_users_path) : (redirect_to item_trading_path(@item, current_user)) 
      return
    end
    @item.destroy && @item.trading_status_id == 4 ? (redirect_to draft_users_path) : (redirect_to exhibition_users_path) 
  end

  def delivery_method
    @delivery_method = DeliveryMethod.find_all_by_flag(params[:flag])
  end

  def price_range
    if params[:price_id].nil?
      @price_range = PriceRange.find_by_min_and_max(params[:min], params[:max])
    else
      @price_range = PriceRange.find(params[:price_id])
    end
  end

  def search
    @trading_status = TradingStatus.find [1,3]
    @keyword = params.require(:q)[:name_or_explanation_cont]
    @search_parents = Category.where(ancestry: nil).where.not(name: "カテゴリー一覧").pluck(:name)

    sort = params[:sort] || "created_at DESC"
    @q = Item.includes(:images).where.not(trading_status_id: 4).search(search_params)
    @items = @q.result(distinct: true).order(sort)

    # 販売状況が検索条件にあるとき
    if trading_status_key = params.require(:q)[:trading_status_id_in]
      if trading_status_key.count == 1 && trading_status_key == ["3"]
        sold_items = Item.where.not(buyer_id: nil)
        @items = @items & sold_items
        @q = Item.includes(:images).search(search_params_for_trading_status)
      elsif trading_status_key.count == 1 && trading_status_key == ["1"]
        selling_items = Item.where(buyer_id: nil)
        @items = @items & selling_items
        @q = Item.includes(:images).search(search_params_for_trading_status)
      elsif trading_status_key.count == 2
        @q = Item.includes(:images).search(search_params_for_trading_status)
      end
    end

    # カテゴリが検索条件にあるとき
    if category_key = params.require(:q)[:category_id]
      if category_key.to_i == 0
        @search_category = Category.find_by(name: category_key, ancestry: nil)
      else
        @search_category = Category.find(category_key)
      end

      if @search_category.present?
        if @search_category.ancestry.nil?
          #親カテゴリ
          @category_child_array = Category.where(ancestry: @search_category.id).pluck(:name, :id)
          grandchildren_id = @search_category.indirect_ids.sort
          find_category_item(grandchildren_id)
        elsif @search_category.ancestry.exclude?("/")
          #子カテゴリ
          @category_child = @search_category
          @category_child_array = @search_category.siblings.pluck(:name, :id)
          @category_grandchild_array = @search_category.children
          grandchildren_id = @search_category.child_ids
          find_category_item(grandchildren_id)
        end
          #孫カテゴリはransackで拾う → category_id_in
      end
    end
    @items = Kaminari.paginate_array(@items).page(params[:page]).per(20)
  end

  private
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
      ],
    ).merge(saler_id: current_user.id)
  end

  def search_params
    params.require(:q).permit(
      :name_or_explanation_cont,
      :category_id,
      :price_gteq,
      :price_lteq,
      category_id_in: [],
      status_id_in: [],
      delivery_charge_flag_in: [],
    )
  end

  def search_params_for_trading_status
    params.require(:q).permit(
      :name_or_explanation_cont,
      :category_id,
      :price_gteq,
      :price_lteq,
      category_id_in: [],
      status_id_in: [],
      delivery_charge_flag_in: [],
      trading_status_id_in: [],
    )
  end

  def find_category_item(grandchildren_id)
    category_item = Item.where(category_id: grandchildren_id[0].. grandchildren_id[-1]).where.not(trading_status_id: 4)
    category_search_items = []
    category_search_items += category_item if category_item.present?
    if category_search_items.length == 0
      @q = Item.search(search_params)
      sort = params[:sort] || "created_at DESC"
      @items = @q.result(distinct: true).order(sort)
    end
    @items = @items & category_search_items
  end
end
