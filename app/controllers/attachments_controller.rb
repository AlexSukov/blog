class AttachmentsController < ApplicationController
  before_action :set_post
  respond_to :json, :html

  def destroy
    remove_attachment_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting attachment" unless @post.save
    redirect_to :back
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def remove_attachment_at_index(index)
    remain_attachments = @post.attachments # copy the array
    remain_attachments.delete_at(index) # delete the target attachment
    @post.attachments = remain_attachments # re-assign back
    @post.remove_attachments! if remain_attachments.empty?
  end
end
