class EInvitation < ActiveRecord::Base
  # The user sending the email invitation.
  belongs_to :sender, class_name: :User
  validates :sender, presence: true
  
  # The tour for which the invitation is being sent.
  belongs_to :tour
  validates :tour, presence: true
  
  # The email address of the invitation's recipient.
  #
  # To avoid receiving many email invitations for the same tour, a recipient
  # can have at most 1 email invitation per tour. 
  validates :recipient, uniqueness: { scope: :tour_id, message: 'has already been invited to this tour' }
  validates :recipient, length: 1..38
  
  # To avoid sending email invitations to users who already joined the tour,
  # the recipient/tour of an EInvitation should not match the user/tour of an
  # existing Invitation.
  validate :ensure_recipient_has_not_already_joined_tour
  
  private
  
    def ensure_recipient_has_not_already_joined_tour
      return if !tour
      unless tour.users.where(email: recipient).empty?
        errors.add(:base, 'The recipient has already joined this tour')
      end
    end
end
