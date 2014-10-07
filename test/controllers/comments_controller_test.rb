require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  setup do
    @comment = comments(:hello_from_birthday_organizer)
    @tour_stop = @comment.tour_stop
    @commenter = @comment.commenter
    
    @attending = users(:accepted_invitation_to_birthday)
    @not_invited = users(:not_invited_to_birthday)
    @undecided = users(:pending_invitation_to_birthday)
    @admin = users(:admin)
  end

  test "users with accepted invitations can comment on tours" do
    login_as @attending
    assert_difference('Comment.count') do
      post :create, comment: { tour_stop_id: @tour_stop, text: 'yay' }
    end
    assert_match(/Comment successfully posted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:comment).tour)
  end
  
  test "users with pending invitations cannot comment on tours" do
    login_as @undecided
    assert_no_difference('Comment.count') do
      post :create, comment: { tour_stop_id: @tour_stop, text: 'yay' }
    end
    assert_match(/Join the tour/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "users without invitations cannot comment on tours" do
    login_as @not_invited
    assert_no_difference('Comment.count') do
      post :create, comment: { tour_stop_id: @tour_stop, text: 'yay' }
    end
    assert_match(/Join the tour/, flash[:notice].inspect)
    assert_redirected_to root_url
  end

  test "user can get her own comment edit page" do
    login_as @commenter
    get :edit, id: @comment
    assert_response :success
  end
  
  test "admin can get any user's comment edit page" do
    login_as @admin
    get :edit, id: @comment
    assert_response :success
  end
  
  test "non-admins cannot get anyone else's comment edit page" do
    login_as @attending
    get :edit, id: @comment
    assert_match(/not your comment/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "user can edit her own comment" do
    login_as @commenter
    assert_match(/Hello./, @comment.text)
    patch :update, id: @comment, comment: { tour_stop_id: @tour_stop,
                                            text: 'Hello World.' }
    assert_match(/World./, assigns(:comment).text)
    assert_match(/successfully updated/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:comment).tour)
  end
  
  test "admin can edit any user's comment" do
    login_as @admin
    
    assert_match(/Hello./, @comment.text)
    patch :update, id: @comment, comment: { tour_stop_id: @tour_stop,
                                            text: 'Hello World.' }
    assert_match(/World./, assigns(:comment).text)
    assert_match(/successfully updated/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:comment).tour)
  end
  
  test "non-admins cannot edit anyone else's comment" do
    login_as @attending
    
    assert_match(/Hello./, @comment.text)
    patch :update, id: @comment, comment: { tour_stop_id: @tour_stop,
                                            text: 'Hello World.' }
    assert_match(/Hello./, assigns(:comment).text)
    assert_match(/not your comment/, flash[:notice].inspect)
    assert_redirected_to root_url
  end

  test "user can destroy her own comment" do
    login_as @commenter
    
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment, tour_stop_id: @tour_stop
    end
    assert_match(/Comment successfully deleted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:comment).tour)
  end
  
  test "admin can destroy any user's comment" do
    login_as @admin
    
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment, tour_stop_id: @tour_stop
    end
    assert_match(/Comment successfully deleted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:comment).tour)
  end
  
  test "non-admins cannot destroy anyone else's comment" do
    login_as @attending
    
    assert_no_difference('Comment.count', -1) do
      delete :destroy, id: @comment, tour_stop_id: @tour_stop
    end
    assert_match(/not your comment/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "must be logged in to post/edit comments" do
    logout
    get :edit, id: @comment
    assert_match(/log back in/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
end
