class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :redirect_to_root, only: [:render_404]
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?
  before_action :set_host

  def render_404
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday])
  end
  
  private

  def production?
    Rails.env.production?
  end

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def redirect_to_root
    redirect_to root_path
  end

  def set_item_search_query
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def set_categories
    @parents = Category.ancestries(nil)
  end

  def item_user?
    redirect_to root_path unless @item.saler_id == current_user.id || @item.buyer_id == current_user.id
  end

  def set_trading_item
    @item = Item.find_by_id(params[:item_id])
  end

  def item_present?
    redirect_to root_path unless @item.present?
  end

  def my_notifications
    @notifications = current_user.passive_notifications.preload(:item, sender: :account)
  end
end
