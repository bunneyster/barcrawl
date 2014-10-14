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
  # Additional error message added when the existing user has an Invitation to
  #     the tour, in order to display a more helpful error message when a user
  #     submits the email of an existing user on the invitation form.
  validate :email_does_not_correspond_to_existing_user
  
  # The tour to which the recipient is being invited.
  belongs_to :tour
  validates :tour, presence: true
  
  # Processes the email input in the new invitation form.
  # Returns the equivalent Invitation for this EInvitation, or nil if the 
  # recipient has a user account.
  def to_invitation
    existing_user = User.where(email: email).first
    return nil if !existing_user # Invitations are for users only
    Invitation.new sender: sender, tour: tour, recipient: existing_user
  end
  
  private
    def email_does_not_correspond_to_existing_user
      existing_user = User.where(email: email).first
      if existing_user
        errors.add(:email, 'already has a user account')
        if tour.invitees.exists? existing_user
          errors.add(:email, 'has already been invited to this tour')
        end
      end
    end
end
