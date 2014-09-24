class Invitation < ActiveRecord::Base
  # The user sending the invitation.
  belongs_to :sender, class_name: :User
  validates :sender, presence: true
  
  # The user receiving the invitation.
  belongs_to :recipient, class_name: :User
  validates :recipient, presence: true
  
  # Users don't receive duplicate Invitations.
  validates :recipient, uniqueness: { scope: :tour_id, message: 'has already been invited to this tour' }
  
  # The tour to which the user is being invited.
  belongs_to :tour
  validates :tour, presence: true
  
  # Whether the user has joined the tour.
  enum status: { pending: 0, accepted: 1, rejected: 2 }
  
end
