class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_user, only: [:update, :destroy]
  before_action :authorize_user
  after_action :verify_authorized

  def show
    @users = User.all.order(role: :desc)
    @user = User.find_by_username(params[:id])
  end

  def update
    @user.update(user_params)
  end

  def destroy
    @user.destroy
  end

  private

  def authorize_user
    authorize current_user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role)
  end
end
