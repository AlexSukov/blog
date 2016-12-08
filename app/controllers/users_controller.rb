class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_username(params[:id])
  end

  private

  def set_comments
    @comments = Comment.where(user_id: current_user.id)
    @posts = Post.where(id: 37)
  end
end
