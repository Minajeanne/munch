class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :full_name
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :reviews
  has_many :restaurants, through: :reviews
end
