class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :json, :html

  def index
    @search = Post.search(params[:q])
    respond_with(@posts = @search.result.order('created_at DESC'))
  end

  def show
  end

  def new
    respond_with(@post = Post.new)
  end

  def edit
    authorize @post
  end

  def create
    authorize @post
    @post = Post.create(post_params)
    respond_with(@post)
  end

  def update
    authorize @post
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    authorize @post
    @post.destroy
    respond_with(@post)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :description).merge(user_id: current_user.id)
  end

end
