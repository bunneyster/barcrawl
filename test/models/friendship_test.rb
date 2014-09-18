require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  setup do
    @friendship = Friendship.new user: users(:peridot),
                                 friend: users(:sam)
  end
  
  test "setup creates valid friendship" do
    assert @friendship.valid?, @friendship.errors.inspect
  end
  
  test "friendship must belong to a user" do
    @friendship.user = nil
    
    assert @friendship.invalid?
    assert_match(/can't be blank/, @friendship.errors[:user].inspect)
  end
  
  test "friendship must belong to a friend" do
    @friendship.friend = nil
    
    assert @friendship.invalid?
    assert_match(/can't be blank/, @friendship.errors[:friend].inspect)
  end
  
  test "friendships can't be duplicated" do
    @friendship.save!
    
    friendship_copy = Friendship.new user: @friendship.user,
                                     friend: @friendship.friend
    
    assert friendship_copy.invalid?
    assert_match(/has already been taken/, friendship_copy.errors.inspect)
    assert_equal 1, Friendship.where(user: @friendship.user, friend: @friendship.friend).count
  end
end
