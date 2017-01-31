class Attachment < ApplicationRecord
  belongs_to :post
  mount_uploader :file_name, AttachmentUploader
end
