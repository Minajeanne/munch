class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password, :full_name

  has_many :reviews
  has_many :restaurants, through :reviews
end
