class User < ActiveRecord::Base
  has_secure_password #adds methods to set & authenticate against Bcrypt password
  validates_presence_of :password, :full_name
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true #validates username & email to ensure uniqueness/prevent same data from being persisted to database more than once.

  has_many :reviews
  has_many :restaurants, through: :reviews
end
