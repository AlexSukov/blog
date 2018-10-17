class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authorize_comment, only: [:edit, :update, :destroy]
  after_action :verify_authorized, except: :create

  respond_to :json, only: [:create, :destroy, :update]

  def show
  end

  def edit
  end

  def create
    @comment = @post.comments.create(comment_params)
    render json: { comment: @comment, created_at: I18n.l(@comment.created_at, format: :short) }
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

  def authorize_comment
    authorize @comment
  end

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
