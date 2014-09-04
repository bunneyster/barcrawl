require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  setup do
    @comment = comments(:hello)
    @tour_stop = @comment.tour_stop
    @commenter = @comment.commenter
    @admin = users(:admin)
    @any_user = users(:dan)
  end

  test "should get new" do
    login_as @any_user
    get :new, tour_stop_id: @tour_stop.to_param
    assert_response :success
  end

  test "users can comment on tours they have joined" do
    login_as @commenter
    
    assert @commenter.invited_to?(@tour_stop.tour)
    assert_difference('Comment.count') do
      post :create, comment: { tour_stop_id: @tour_stop.to_param,
                               text: 'yay' }
    end

    assert_match(/Comment successfully posted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:comment).tour)
  end
  
  test "users cannot comment on tours they have not joined" do
    login_as @any_user
    
    assert_not @any_user.invited_to?(@tour_stop.tour)
    assert_no_difference('Comment.count') do
      post :create, comment: { tour_stop_id: @tour_stop.to_param,
                               text: 'yay' }
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
    login_as @any_user
    
    get :edit, id: @comment
    assert_match(/not your comment/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "user can edit her own comment" do
    login_as @commenter
    
    assert_match(/Hello./, @comment.text)
    patch :update, id: @comment, comment: { tour_stop_id: @tour_stop.to_param,
                                            text: 'Hello World.' }
    assert_match(/World./, assigns(:comment).text)
    assert_match(/successfully updated/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:comment).tour)
  end
  
  test "admin can edit any user's comment" do
    login_as @admin
    
    assert_match(/Hello./, @comment.text)
    patch :update, id: @comment, comment: { tour_stop_id: @tour_stop.to_param,
                                            text: 'Hello World.' }
    assert_match(/World./, assigns(:comment).text)
    assert_match(/successfully updated/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:comment).tour)
  end
  
  test "non-admins cannot edit anyone else's comment" do
    login_as @any_user
    
    assert_match(/Hello./, @comment.text)
    patch :update, id: @comment, comment: { tour_stop_id: @tour_stop.to_param,
                                            text: 'Hello World.' }
    assert_match(/Hello./, assigns(:comment).text)
    assert_match(/not your comment/, flash[:notice].inspect)
    assert_redirected_to root_url
  end

  test "user can destroy her own comment" do
    login_as @commenter
    
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment, tour_stop_id: @tour_stop.to_param
    end
    assert_match(/Comment successfully deleted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:comment).tour)
  end
  
  test "admin can destroy any user's comment" do
    login_as @admin
    
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment, tour_stop_id: @tour_stop.to_param
    end
    assert_match(/Comment successfully deleted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:comment).tour)
  end
  
  test "non-admins cannot destroy anyone else's comment" do
    login_as @any_user
    
    assert_no_difference('Comment.count', -1) do
      delete :destroy, id: @comment, tour_stop_id: @tour_stop.to_param
    end
    assert_match(/not your comment/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "must be logged in to post/edit comments" do
    logout
    get :new, tour_stop_id: @tour_stop.to_param
    assert_match(/log back in/, flash[:notice].inspect)
    assert_redirected_to root_url
  end

end
