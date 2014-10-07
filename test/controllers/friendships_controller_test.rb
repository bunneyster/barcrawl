require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  setup do
    @friendship = friendships(:s2d)
    @user = users(:peridot)
    @friendless = users(:friendless_user)
    login_as @user
  end

  test "should only create friendship if not already friends" do
    assert_not Friendship.where(user: @user, friend: @friendless).exists?
        
    assert_difference('Friendship.count') do
      post :create, friend_id: @friendless.id
    end

    assert_match(/successfully created/, flash[:notice].inspect)
    assert_redirected_to root_url
    
    assert_no_difference('Friendship.count') do
      post :create, friend_id: @friendless.id
    end
  end

  test "should destroy friendship" do
    assert_difference('Friendship.count', -1) do
      delete :destroy, id: @friendship
    end

    assert_match(/successfully destroyed/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "should be logged in to add friend" do
    logout
    
    assert_no_difference('Friendship.count') do
      post :create, friend_id: @friendless.id
    end
    
    assert_redirected_to root_url
  end
end
