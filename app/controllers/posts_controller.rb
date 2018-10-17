class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_category
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post, except: [:index, :show, :new, :create]
  before_action :authorize_user, only: [:new, :create]
  before_action :set_aws, only: [:new, :edit, :update]
  after_action :verify_authorized, except: [:index, :show]

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

  def authorize_user
    authorize current_user
  end

  def authorize_post
    authorize @post
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_post
    @post = @category.posts.find(params[:id])
  end

  def set_aws
    options = {
      # The name of your bucket.
      bucket: 'math4all-froala',

      # S3 region. If you are using the default us-east-1, it this can be ignored.
      region: 'eu-west-1',

      # The folder where to upload the images.
      keyStart: 'froala_files/',

      # File access.
      acl: 'public-read',

      # AWS keys.
      accessKey: Rails.application.secrets.secret_key_aws_id,
      secretKey: Rails.application.secrets.secret_key_aws_password
    }

    # Compute the signature.
    gon.aws_data = FroalaEditorSDK::S3.data_hash(options)
  end

  def post_params
    params.require(:post).permit(:title, :body, :image, :description).merge(user_id: current_user.id)
  end

end
