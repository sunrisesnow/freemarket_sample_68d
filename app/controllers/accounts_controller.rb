class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :new, :update, :destroy]
  before_action :set_category_brand
  def new
    redirect_to edit_account_path(@account) if @account.present?
  end
  
  def create
    account = Account.new(account_new_params)
    account.save! ? (redirect_to edit_account_path(account)) : (render :new)
  end

  def edit
    render :new unless @account.present?
  end

  def update
    @account.update!(account_edit_params) ? (redirect_to edit_account_path(@account)) : (redirect_to root_path)
  end

  def destroy
    redirect_to root_path unless current_user.id == @account.user_id
    @account.destroy! ? (redirect_to user_path(current_user)) : (redirect_to edit_account_path(@account))
  end

  private

  def set_account
    @account = Account.find_by(user_id: current_user.id)
  end

  def account_new_params
    params.permit(:icon_image, :background_image, :introduction).merge(user_id: current_user.id)
  end

  def account_edit_params
    params.require(:account).permit(:icon_image, :background_image, :introduction).merge(user_id: current_user.id)
  end

  def set_category_brand
    @parents = Category.where(ancestry: nil)
    @brands = ["シャネル","ナイキ", "ルイヴィトン", "シュプリーム","アディダス"]
  end
end
