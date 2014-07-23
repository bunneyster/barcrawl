class Tour < ActiveRecord::Base
  belongs_to :organizer, class_name: :User
  validates :organizer, presence: true
  
  belongs_to :city
  validates :city, presence: true

  validates :name, presence: true, length: 1..128
 
  validates :starting_at, presence: true,
            timeliness: { on_or_after: lambda { DateTime.current } }

  has_many :tour_stops, dependent: :destroy

  # Invitations extended for this tour.  
  has_many :invitations
  
  # Users invited to this tour.
  has_many :users, through: :invitations   
end
