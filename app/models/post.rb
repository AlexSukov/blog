class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user, optional: true
  ratyrate_rateable 'post_rating'
  mount_uploader :image, ImageUploader
end
