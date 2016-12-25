class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def show
    @users = User.all
    @user = User.find_by_username(params[:id])
  end

end
