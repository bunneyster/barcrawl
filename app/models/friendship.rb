class Friendship < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  
  belongs_to :friend, class_name: :User
  validates :friend, presence: true
  
  before_create :ensure_not_already_friends
  
  private
  
    def ensure_not_already_friends
      if Friendship.where(user: self.user, friend: self.friend).empty?
        return true
      else
        errors.add(:base, 'Already friends')
        return false
      end
    end
end
