class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login
  enum role: [:user, :moderator, :admin]
  has_many :posts
  has_many :comments
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #overwrite Devise's find_for_database_authentication method
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      if conditions[:username].nil?
        #make email to be case insensitive
        conditions[:email].downcase! if conditions[:email]
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end
  #make username to be case insensitive
  validates :username,
    presence: true,
    uniqueness: {
      case_sensitive: false
    }
  validates_format_of :username, with: /\A[a-zA-Z0-9_\.]+\z/
  ratyrate_rater
end
