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
  end

  def create
    @post = Post.create(post_params)
    save_attachments if params[:attachments].present?
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    save_attachments if params[:attachments].present?
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
    params.require(:post).permit(:title, :body, :user_id, attachments_attributes: [:post_id, :file_name]).merge(user_id: current_user.id)
  end

  def save_attachments
    num = params[:attachments][:file_name].size
    for i in (0...num) do
      file_name = params[:attachments][:file_name]["#{i}"]
      @attachments = @post.attachments.create!(file_name: file_name)
    end
  end

end
