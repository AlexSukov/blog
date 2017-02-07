class AttachmentsController < ApplicationController
  before_action :set_attachment, only: :destroy
  before_action :set_post
  respond_to :json, only: [:create, :destroy]

 def new
   @attachment = Attachment.new
 end

 def create
   @attachment = @post.attachments.create(attachment_params)
   respond_with(@post, @attachment)
 end

 def destroy
   @attachment.destroy
   respond_with(@post, @attachment)
 end
 private

 def set_post
   @post = Post.find(params[:post_id])
 end

 def set_attachment
   @attachment = Attachment.find(params[:id])
 end

 def attachment_params
   params.require(:attachment).permit(:file_name, :post_id)
 end
end
