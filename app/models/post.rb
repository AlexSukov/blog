class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user, optional: true
<<<<<<< HEAD
  ratyrate_rateable 'post_rating'
=======
  mount_uploaders :attachments, AttachmentUploader
>>>>>>> #19: Added carrierwave
end
