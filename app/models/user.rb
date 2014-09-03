class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships
  
  has_many :invitations
  has_many :tours, through: :invitations
  
  has_many :votes
  
  validates :email, uniqueness: true
  validates :email, length: 1..38
  
  validates :name, length: 1..28
  
  validates :admin, inclusion: { in: [true, false] }
    
  # Validates presence of password on create, confirmation of password
  has_secure_password
  
  def avatar_url=(new_avatar_url)
    new_avatar_url = nil if new_avatar_url.blank?
    super new_avatar_url
  end
  
  def invited_to?(tour)
    tour.users.where(id: id).exists?
  end
end
