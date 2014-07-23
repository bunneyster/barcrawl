class Venue < ActiveRecord::Base
  belongs_to :city
  # or have a hook?: before_destroy :ensure_not_referenced_by_any_tour_stop
  # useful?: has_many :tours, through: :tour_stops
  
  validates :name, :city, :cid, :latitude, :longitude, presence: true
  validates :name, :cid, uniqueness: true
end
