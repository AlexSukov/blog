class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login
  has_many :posts
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #overwrite Devise's find_for_database_authentication method
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
    #make email to be case insensitive
    conditions[:email].downcase! if conditions[:email]
    where(conditions.to_h).first
  end
  #make username to be case insensitive
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
end
