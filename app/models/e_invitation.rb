class EInvitation < ActiveRecord::Base
  # The user sending the email invitation.
  belongs_to :sender, class_name: :User
  validates :sender, presence: true
  
  # The tour for which the invitation is being sent.
  belongs_to :tour
  validates :tour, presence: true
  
  # The email address of the invitation's recipient.
  validates :recipient, uniqueness: { message: 'has already been invited to this tour' }
  validates :recipient, length: 1..38
  
  # EInvitations and Invitations for the same recipient/tour shouldn't exist 
  # concurrently.
  validate :ensure_recipient_has_not_already_joined_tour
  
  private
  
    def ensure_recipient_has_not_already_joined_tour
      return if !tour
      unless tour.users.where(email: recipient).empty?
        errors.add(:base, 'The recipient has already joined this tour')
      end
    end
end
