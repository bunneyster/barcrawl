class Invitation < ActiveRecord::Base
  # The user receiving an invitation.
  belongs_to :user
  validates :user, presence: true
  
  # The tour to which the user is being invited.
  belongs_to :tour
  validates :tour, presence: true
  validates :tour_id, uniqueness: { scope: :user_id }
  
  
end
