class Review < ActiveRecord::Base
  validates_presence_of :title, :experience, :rating

  belongs_to :user
  belongs_to :restaurant
end
