require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  fixtures :users
  
  setup do
    @user = users(:peridot)
  end

  test "valid login redirects to root" do
    post :create, email: @user.email, password: 'peridot'
    assert_match(/Welcome/, flash[:alert])
    assert_redirected_to root_url
    assert_equal users(:peridot).id, session[:user_id]
  end
  
  test "invalid login redirects to root" do
    post :create, email: @user.email, password: 'not peridot'
    assert_match(/Invalid/, flash[:alert])
    assert_redirected_to root_url
  end

  test "logout redirects to root" do
    login_as @user
    assert_equal session[:user_id], @user.id
    
    get :destroy
    assert_nil session[:user_id]
    assert_match(/Logged out/, flash[:alert])
    assert_redirected_to root_url
  end

end
