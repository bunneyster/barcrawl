require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  setup do
    @friendship = friendships(:s2d)
    @user = users(:peridot)
    login_as @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friendships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should only create friendship if not already friends" do
    assert_not Friendship.where(user: @user, friend: users(:sam)).exists?
        
    assert_difference('Friendship.count') do
      post :create, friend_id: users(:sam).id
    end

    assert_match(/successfully created/, flash[:notice].inspect)
    assert_redirected_to root_url
    
    assert_no_difference('Friendship.count') do
      post :create, friend_id: users(:sam).id
    end
  end

  test "should show friendship" do
    get :show, id: @friendship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @friendship
    assert_response :success
  end

  test "should update friendship" do
    patch :update, id: @friendship, friendship: { friend_id: @friendship.friend_id,
                                                  user_id: @friendship.user_id }
    
    assert_match(/successfully updated/, flash[:notice].inspect)
    assert_redirected_to friendship_path(assigns(:friendship))
  end

  test "should destroy friendship" do
    assert_difference('Friendship.count', -1) do
      delete :destroy, id: @friendship
    end

    assert_match(/successfully destroyed/, flash[:notice].inspect)
    assert_redirected_to friendships_path
  end
  
  test "should be logged in to add friend" do
    logout
    
    assert_no_difference('Friendship.count') do
      post :create, friend_id: users(:sam).id
    end
    
    assert_redirected_to root_url
  end
end
