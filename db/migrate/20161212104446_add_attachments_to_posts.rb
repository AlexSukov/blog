class AddAttachmentsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :attachments, :text, array: true, default: []
  end
end
