class Friendship < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  
  belongs_to :friend, class_name: :User
  validates :friend, presence: true
  validates :friend_id, uniqueness: { scope: :user_id }  
end
