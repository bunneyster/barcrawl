require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  fixtures :users
  
  setup do
    @user = users(:peridot)
  end
   
  test "logged user renders dashboard" do
    user = users(:peridot)
    session[:user_id] = user.to_param
    get :new
    assert_response :success
    assert_template :dashboard
  end
  
  test "unlogged user renders welcome" do
    session[:user_id] = nil
    get :new
    assert_response :success
    assert_template :welcome
  end

  test "valid login redirects to root" do
    post :create, session: { email: @user.email, password: 'peridot' }
    assert_match(/Welcome/, flash[:alert])
    assert_redirected_to root_url
    assert_equal users(:peridot).to_param, session[:user_id]
  end
  
  test "invalid login redirects to root" do
    post :create, session: { email: @user.email, password: 'not peridot' }
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
