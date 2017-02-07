class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: proc { |attributes| attributes[:file_name].blank? }, allow_destroy: true
  belongs_to :user, optional: true
  ratyrate_rateable 'post_rating'
  mount_uploaders :attachments, AttachmentUploader
end
