class TourStop < ActiveRecord::Base
  # Tour containing this tour stop.
  belongs_to :tour
  validates :tour, presence: true
  
  # Venue where this tour stop takes place.
  belongs_to :venue
  validates :venue, presence: true
  
  # Votes that have been cast for/against this tour stop's proposed venue.
  has_many :votes
  
  # Comments posted regarding this tour stop.
  has_many :comments
  
  # Whether this tour stop will be included in the finalized tour itinerary.
  enum status: { maybe: 0, yes: 1, no: 2 }
  
  def votes_from(user)
    TourStop.find(self[:id]).votes.where(voter: user)
  end
  
  def total_score
    TourStop.find(self[:id]).votes.inject(0) {|sum, vote| sum + vote.score }
  end
end
