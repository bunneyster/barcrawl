class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships
  
  has_many :invitations, foreign_key: :recipient_id, inverse_of: :recipient
  has_many :tours, through: :invitations
  
  has_many :votes
  
  validates :email, uniqueness: true, length: 1..38, format: /\A.*@.*\..*\Z/
  
  validates :name, length: 1..28
  
  validates :admin, inclusion: { in: [true, false] }
    
  # Validates presence of password on create, confirmation of password
  has_secure_password
  
  # Any EInvitations for this user should be converted to Invitations.
  after_create :convert_existing_e_invitations
  
  def avatar_url=(new_avatar_url)
    new_avatar_url = nil if new_avatar_url.blank?
    super new_avatar_url
  end
  
  def invited_to?(tour)
    tour.invitees.exists?(id: id)
  end
  
  def attending?(tour)
    if tour.invitation_for(self)
      tour.invitation_for(self).status == 'accepted'
    else
      return false
    end
  end
  
  private
  
    def convert_existing_e_invitations
      EInvitation.where(recipient: email).each do |e_invitation|
        invitations.create! sender: e_invitation.sender, recipient: self, 
                            tour: e_invitation.tour
        e_invitation.destroy!
      end
    end
end
