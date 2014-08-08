class Venue < ActiveRecord::Base
  belongs_to :city
  # useful?: has_many :tours, through: :tour_stops
  
  before_destroy :ensure_not_referenced_by_any_tour_stop
  
  validates :name, :city, :cid, :latitude, :longitude, presence: true
  validates :name, :cid, uniqueness: true
  
  # <%= f.label :venue, 'Venues:' %><br>
  # <%= f.collection_select :venue_id, Venue.unproposed_for(@tour_stop), :id, :name, :include_blank => "Please select a venue..." %>
  def self.unproposed_for(tour_stop)
    local_venues = Venue.where(city: tour_stop.tour.city).order(:name)
    proposed_venues = tour_stop.tour.venues
    local_venues - proposed_venues
  end
    
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
