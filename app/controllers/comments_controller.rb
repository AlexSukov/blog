class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  respond_to :json, only: [:create, :destroy, :update]

  def show
  end

  def edit
    authorize @comment
  end

  def create
    @comment = @post.comments.create(comment_params)
    render json: { comment: @comment, created_at: I18n.l(@comment.created_at, format: :short) }
  end

  def update
    authorize @comment
    @comment.update(comment_params)
    respond_with(@post, @comment)
  end

  def destroy
    authorize @comment
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
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
