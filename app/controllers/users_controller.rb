class UsersController < ApplicationController
  before_action :set_item_search_query
  before_action :set_categories
  before_action :my_notifications
  
  def index
  end

  def show
  end

  def draft
    @items = Item.draft(current_user.id).page(params[:page]).per(12)
  end

  def exhibition
    @items = Item.exhibition(current_user.id).page(params[:page]).per(12)
  end

  def exhibition_trading
    @items = Item.exhibition_trading(current_user.id).page(params[:page]).per(12)
  end

  def exhibition_completed
    @items = Item.exhibition_completed(current_user.id).page(params[:page]).per(12)
  end

  def bought
    @items = Item.bought(current_user.id).page(params[:page]).per(12)
  end

  def bought_completed
    @items = Item.bought_completed(current_user.id).page(params[:page]).per(12)
  end
end
