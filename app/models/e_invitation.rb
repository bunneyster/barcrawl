# Invitations that are addressed to email addresses, rather than User instances.
class EInvitation < ActiveRecord::Base
  # The user sending the email invitation.
  belongs_to :sender, class_name: :User
  validates :sender, presence: true
  
  # The email address receiving the email invitation.
  validates :recipient, length: 1..38
  
  # The tour to which the recipient is being invited.
  belongs_to :tour
  validates :tour, presence: true

  # Recipients don't receive duplicate EInvitations.
  validates :recipient, uniqueness: { scope: :tour_id, message: 'has already been e-invited to this tour' }
  
  # Recipients with Invitations don't receive equivalent EInvitations.
  validate :ensure_recipient_has_not_already_joined_tour
  
  # Recipients with existing accounts don't receive EInvitations.
  validate :recipient_does_not_correspond_to_existing_user
  
  private
  
    def ensure_recipient_has_not_already_joined_tour
      return if !tour
      unless !tour.invitees.exists?(email: recipient)
        errors.add(:base, 'The recipient has already joined this tour')
      end
    end
    
    def recipient_does_not_correspond_to_existing_user
      unless !User.exists?(email: recipient)
        errors.add(:recipient, 'The recipient already has a user account')
      end
    end
end
