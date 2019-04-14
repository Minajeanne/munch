class Restaurant < ActiveRecord::Base
  validates_presence_of :cuisine, :location #:overall_rating
  validates :name, presence: true, uniqueness: true

  has_many :reviews
  has_many :users, through: :reviews
end
