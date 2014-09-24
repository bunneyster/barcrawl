class Invitation < ActiveRecord::Base
  # The user receiving an invitation.
  belongs_to :user
  validates :user, presence: true
  
  # Users don't receive duplicate Invitations.
  validates :user, uniqueness: { scope: :tour_id, message: 'has already been invited to this tour' }
  
  # The tour to which the user is being invited.
  belongs_to :tour
  validates :tour, presence: true
  
  # Whether the user has joined the tour.
  enum status: { pending: 0, accepted: 1, rejected: 2 }
  
end
