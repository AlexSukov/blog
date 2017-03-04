class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_category
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post, except: [:index, :new, :show]
  after_action :verify_authorized, except: [:new, :index, :show]

  respond_to :json, :html

  def show
    respond_with(@post)
  end

  def new
    respond_with(@post = @category.posts.new)
  end

  def edit
  end

  def create
    @post = @category.posts.create(post_params)
    respond_with(@category, @post)
  end

  def update
    @post.update(post_params)
    respond_with(@category, @post)
  end

  def destroy
    @post.destroy
    respond_with(@category)
  end

  private

  def authorize_post
    authorize @post
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_post
    @post = @category.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :description, :category_id).merge(user_id: current_user.id)
  end

end
