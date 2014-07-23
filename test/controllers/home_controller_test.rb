require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  fixtures :users
  
  test "unlogged user renders welcome" do
    session[:user_id] = nil
    get :home
    assert_response :success
    assert_template :welcome
  end
  
  test "logged user renders dashboard" do
    user = users(:peridot)
    session[:user_id] = user.id
    get :home
    assert_response :success
    assert_template :dashboard
  end

end
