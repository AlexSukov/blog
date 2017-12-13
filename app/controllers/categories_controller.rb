class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authorize_category, except: [:index, :new, :show, :create]
  before_action :authorize_user, only: [:new, :create]
  after_action :verify_authorized, except: [:index, :show]

  respond_to :json, :html

  def index
    @categories = Category.all
    @posts = Post.last(3)
    @posts = @posts.sort_by{|m| m[:time_ago]}.reverse
    respond_with(@categories, @posts)
  end

  def show
    @search = @category.posts.search(params[:q])
    respond_with(@posts = @search.result.order('created_at DESC'))
  end

  def new
    respond_with(@category = Category.new)
  end

  def edit
  end

  def create
    @category = Category.create(category_params)
    respond_with(@category)
  end

  def update
    @category.update(category_params)
    respond_with(@category)
  end

  def destroy
    @category.destroy
    respond_with(@category)
  end

  private

  def authorize_user
    authorize current_user
  end

  def authorize_category
    authorize @category
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :image, :user_id).merge(user_id: current_user.id)
  end
end
