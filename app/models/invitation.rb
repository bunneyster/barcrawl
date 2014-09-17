class Invitation < ActiveRecord::Base
  # The user receiving an invitation.
  belongs_to :user
  validates :user, presence: true
  
  # The tour to which the user is being invited.
  belongs_to :tour
  validates :tour, presence: true
  
  before_create :ensure_user_has_not_already_joined_tour
  
  private
  
    def ensure_user_has_not_already_joined_tour
      if Invitation.where(user: self.user, tour: self.tour).empty?
        return true
      else
        errors.add(:user, 'has already joined the tour')
        return false
      end
    end
end
