class Friendship < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  
  belongs_to :friend, class_name: :User
  validates :friend, presence: true
  
  before_create :ensure_friendship_does_not_already_exist
  
  private
  
    def ensure_friendship_does_not_already_exist
      if Friendship.where(user: self.user, friend: self.friend).empty?
        return true
      else
        errors.add(:base, 'This friendship has already been established')
        return false
      end
    end
end
