class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?
  before_action :set_host
  
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

  def set_category_brand
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
end
