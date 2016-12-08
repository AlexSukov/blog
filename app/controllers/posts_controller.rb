class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_author, only: :new
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  respond_to :json, :html

  def index
    respond_with(@posts = Post.all.order('created_at DESC'))
  end

  def show
    @comment = @post.comments.new
  end

  def new
    respond_with(@post = Post.new)
  end

  def edit
  end

  def create
    @post = Post.create(post_params)
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def set_author
    @author = current_user
  end
end
