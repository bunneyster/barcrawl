class TourStop < ActiveRecord::Base
  # Tour containing this tour stop.
  belongs_to :tour
  validates :tour, presence: true
  
  # Venue where this tour stop takes place.
  belongs_to :venue
  validates :venue, presence: true
  
  validate :does_not_already_exist, on: :create
  
  # Votes that have been cast for/against this tour stop's proposed venue.
  has_many :votes, dependent: :destroy
  
  # Comments posted regarding this tour stop.
  has_many :comments
  
  # Whether this tour stop will be included in the finalized tour itinerary.
  enum status: { maybe: 0, yes: 1, no: 2 }
  
  # Use in VotesController to determine tour stop's total score.    
  def votes_from(user)
    self.votes.where(voter: user)
  end
  
  def upvoted_by(user)
    vote = self.votes_from(user).first 
    vote.score > 0 if vote
  end
  
  def downvoted_by(user)
    vote = self.votes_from(user).first 
    vote.score < 0 if vote
  end
  
  # Use in 'voting_line_item' to display tour stop's total score.
  def total_score
    self.votes.inject(0) {|sum, vote| sum + vote.score }
  end
  
  def new_comment
    Comment.new(tour_stop: self)
  end
  
  private
  
    def does_not_already_exist
      if TourStop.where(tour: self.tour, venue: self.venue).empty?
        return true
      else
        errors.add(:base, 'This venue has already been proposed.')
        return false
      end
    end
end
