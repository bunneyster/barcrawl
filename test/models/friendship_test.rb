require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  setup do
    @friendship = Friendship.new user: users(:peridot),
                                 friend: users(:allison)
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
end
