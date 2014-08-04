class Tour < ActiveRecord::Base
  # Use a random URL-safe base64 string of length 64 as the primary key.
  self.primary_key = :id
  
  belongs_to :organizer, class_name: :User
  validates :organizer, presence: true
  
  belongs_to :city
  validates :city, presence: true

  validates :name, presence: true, length: 1..128
 
  validates :starting_at, presence: true,
            timeliness: { on_or_after: lambda { DateTime.current } }

  validates :description, length: { maximum: 1000 }
  
  # Tour stops proposed/accepted to be included this tour.
  has_many :tour_stops, dependent: :destroy
  
  # Venues where the stops on this tour take place.
  has_many :venues, through: :tour_stops

  # Invitations extended for this tour.  
  has_many :invitations
  
  # Users invited to this tour.
  has_many :users, through: :invitations
  
  before_validation :generate_id
  
  # After the tour record is first created, add the organizer to the tour.
  after_create :invite_organizer_to_tour
  
  # Whether this tour has been finalized by the organizer.
  enum status: { pending: 0, finalized: 1 }
  
  def invitation_for(user)
    self.invitations.where(user: user)
  end
  
  def new_invitation
    Invitation.new(tour: Tour.find(self[:id]))
  end
  
  def organized_by?(user)
    user === self.organizer
  end
      
  def to_param
    id
  end
  
  # private
  
    def generate_id
      self.id ||= SecureRandom.urlsafe_base64 48
    end

    
    def invite_organizer_to_tour
      Invitation.create(user: User.find(self[:organizer_id]),
                        tour: Tour.find(self[:id]))
    end
end
