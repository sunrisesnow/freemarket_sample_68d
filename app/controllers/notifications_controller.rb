class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories
  before_action :set_item
  before_action :set_item_search_query
  before_action :my_notifications

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
      ]
    ).merge(saler_id: current_user.id)
    end
end
