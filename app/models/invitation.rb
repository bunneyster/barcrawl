class Invitation < ActiveRecord::Base
  # The user receiving an invitation.
  belongs_to :user
  
  # The tour to which the user is being invited.
  belongs_to :tour
end
