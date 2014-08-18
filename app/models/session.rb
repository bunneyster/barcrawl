class Session
  include ActiveModel::Model
  
  attr_accessor :email  
  validates :email, length: 1..38
  
  attr_accessor :password
  validates :password, presence: true
end
