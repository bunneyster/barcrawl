class Venue < ActiveRecord::Base
  belongs_to :city
  # or have a hook?: before_destroy :ensure_not_referenced_by_any_tour_stop
  # useful?: has_many :tours, through: :tour_stops
  
  before_destroy :ensure_not_referenced_by_any_tour_stop
  
  validates :name, :city, :cid, :latitude, :longitude, presence: true
  validates :name, :cid, uniqueness: true
  
  private
  
    def ensure_not_referenced_by_any_tour_stop
      if TourStop.where(venue: Venue.find(self[:id])).empty?
        return true
      else
        errors.add(:base, 'Tour Stops referencing this venue are present.')
        return false
      end
    end
end
