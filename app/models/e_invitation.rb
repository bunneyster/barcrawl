# Invitations that are addressed to email addresses, rather than User instances.
class EInvitation < ActiveRecord::Base
  # The tour for which the invitation is being sent.
  belongs_to :tour
  validates :tour, presence: true
  
  # The email address of the invitation's recipient.
  validates :recipient, length: 1..38

  # Users don't receive duplicate EInvitations.
  validates :recipient, uniqueness: { scope: :tour_id, message: 'has already been e-invited to this tour' }
  
  # Users with Invitations don't receive equivalent EInvitations.
  validate :ensure_recipient_has_not_already_joined_tour
  
  # Users with existing accounts don't receive EInvitations.
  validate :recipient_does_not_correspond_to_existing_user
  
  private
  
    def ensure_recipient_has_not_already_joined_tour
      return if !tour
      unless !tour.users.exists?(email: recipient)
        errors.add(:base, 'The recipient has already joined this tour')
      end
    end
    
    def recipient_does_not_correspond_to_existing_user
      unless !User.exists?(email: recipient)
        errors.add(:recipient, 'The recipient already has a user account')
      end
    end
end
