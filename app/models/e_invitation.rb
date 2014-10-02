# Invitations that are addressed to email addresses, rather than User instances.
class EInvitation < ActiveRecord::Base
  # The user sending the email invitation.
  belongs_to :sender, class_name: :User
  validates :sender, presence: true
  
  # The email address receiving the email invitation.
  validates :email, length: 1..38
  
  # Recipients don't receive duplicate EInvitations for the same tour.
  validates :email, uniqueness: { scope: :tour_id, message: 'has already been e-invited to this tour' }  
  
  # Users with existing accounts don't receive EInvitations.
  # (Normal Invitation should be created.)
  validate :email_does_not_correspond_to_existing_user
  
  # The tour to which the recipient is being invited.
  belongs_to :tour
  validates :tour, presence: true
  
  private
    def email_does_not_correspond_to_existing_user
      if User.exists?(email: email)
        errors.add(:email, 'already has a user account')
      end
    end
end
