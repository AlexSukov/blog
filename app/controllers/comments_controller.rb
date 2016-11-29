class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  respond_to :json, only: [:create, :destroy]

  def show
  end

  def edit
  end

  def create
    @comment = @post.comments.create(comment_params)
    respond_with(@post, @comment)
  end

  def update
    @comment.update(comment_params)
    respond_with(@post, @comment)
  end

  def destroy
    @comment.destroy
    respond_with(@post, @comment)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end
