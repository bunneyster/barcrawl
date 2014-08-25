require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  setup do
    @tour_stop = tour_stops(:first)
    @comment = comments(:hello)
    @user = users(:peridot)
    login_as @user
  end

  test "should get new" do
    get :new, tour_stop_id: @tour_stop.to_param
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: { tour_stop_id: @tour_stop.to_param,
                               text: 'yay' }
    end

    assert_match(/Comment successfully posted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should get edit" do
    get :edit, id: @comment
    assert_response :success
  end
  
  test "should update comment" do
    assert_match(/Hello./, @comment.text)
    patch :update, id: @comment, comment: { tour_stop_id: @tour_stop.to_param,
                                            text: 'Hello World.' }
    assert_match(/World./, assigns(:comment).text)
    assert_match(/successfully updated/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment, tour_stop_id: @tour_stop.to_param
    end

    assert_match(/Comment successfully deleted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour))
  end
  
  test "must be logged in to post comments" do
    logout
    get :new, tour_stop_id: @tour_stop.to_param
    assert_redirected_to root_url
  end

end
