class Restaurant < ActiveRecord::Base
  validates_presence_of :name, :cuisine, :location, #:overall_rating

  has_many :reviews
  has_many :users, through :reviews
end
