class Invitation < ActiveRecord::Base
  # The user receiving an invitation.
  belongs_to :user
  validates :user, presence: true
  validates :user, uniqueness: { scope: :tour_id, message: 'has already been invited to this tour' }
  
  # The tour to which the user is being invited.
  belongs_to :tour
  validates :tour, presence: true
  
  
  
end
