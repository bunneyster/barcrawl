class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships
  
  has_many :invitations
  has_many :tours, through: :invitations
  
  validates :email, uniqueness: true
  validates :name, :email, presence: true
  
  # Validates presence of password on create, confirmation of password
  has_secure_password
  
=begin
  scope :friends_with, ->(other) do
    other = other.id if other.is_a?( User )
    where('(friendships.user_id = users.id AND friendships.friend_id = ?) OR
           (friendships.user_id = ? AND friendships.friend_id = users.id)',
           other, other ).includes( :frienships )
  end
=end
  
end
