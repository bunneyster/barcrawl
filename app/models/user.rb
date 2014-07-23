class User < ActiveRecord::Base
  has_many :invitations
  has_many :tours, through: :invitations
  
  validates :email, uniqueness: true
  validates :name, :email, presence: true
  
  # Validates presence of password on create, confirmation of password
  has_secure_password
end
