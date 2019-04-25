class Restaurant < ActiveRecord::Base
  validates_presence_of :cuisine, :location #:overall_rating
  validates :name, presence: true, uniqueness: true #validates restaurant name to ensure uniqueness/prevent same restaurant from being persisted to database more than once.

  has_many :reviews
  has_many :users, through: :reviews
end
