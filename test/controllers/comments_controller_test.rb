require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  setup do
    @comment = comments(:hello)
    @user = users(:peridot)
    login_as @user
  end
    
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new, tour_stop_id: tour_stops(:first).id
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: { tour_stop_id: tour_stops(:first).id,
                               text: 'yay' }
    end

    assert_match(/Comment successfully posted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should show comment" do
    get :show, id: @comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment
    assert_response :success
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to tour_path(assigns(:tour))
  end

end
