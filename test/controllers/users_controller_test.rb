require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @me = users(:peridot)
    @not_me = users(:sam)
    @admin = users(:admin)
  end

  test "should get index" do
    login_as @me
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name: 'user',
                            email: 'user@test.com',
                            password: 'secret',
                            password_confirmation: 'secret' }
    end

    assert_redirected_to root_url
  end

  test "should show user" do
    login_as @me
    get :show, id: @me
    assert_response :success
  end

  test "user can get her own profile edit page" do
    login_as @me
    get :edit, id: @me
    assert_response :success
  end
  
  test "admin can get any user's profile edit page" do
    login_as @admin
    get :edit, id: @me
    assert_response :success
  end
  
  test "non-admins cannot get someone else's profile edit page" do
    login_as @not_me
    get :edit, id: @me
    assert_match(/cannot access/, flash[:notice].inspect)
    assert_redirected_to root_url
  end

  test "user can update her own profile" do
    login_as @me
    patch :update, id: @me, user: { email: @me.email,
                                      name: @me.name, 
                                      password: 'secret',
                                      password_confirmation: 'secret', 
                                      avatar_url: @me.avatar_url }
    assert_match(/Account updated/, flash[:notice].inspect)
    assert_redirected_to user_path(assigns(:user))
  end
  
  test "admin can update any user's profile" do
    login_as @admin
    patch :update, id: @me, user: { email: @me.email,
                                      name: @me.name, 
                                      password: 'secret',
                                      password_confirmation: 'secret', 
                                      avatar_url: @me.avatar_url }
    assert_match(/Account updated/, flash[:notice].inspect)
    assert_redirected_to user_path(assigns(:user))
  end
  
  test "non-admins cannot update someone else's profile" do
    login_as @not_me
    patch :update, id: @me, user: { email: @me.email,
                                      name: @me.name, 
                                      password: 'secret',
                                      password_confirmation: 'secret', 
                                      avatar_url: @me.avatar_url }
    assert_match(/cannot access/, flash[:notice].inspect)
    assert_redirected_to root_url
  end

  test "user can destroy her own profile" do
    login_as @me
    assert_difference('User.count', -1) do
      delete :destroy, id: @me
    end
    assert_match(/successfully destroyed/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "admin can destroy any user's profile" do
    login_as @admin
    assert_difference('User.count', -1) do
      delete :destroy, id: @me
    end
    assert_match(/successfully destroyed/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "non-admins cannot destroy someone else's profile" do
    login_as @not_me
    assert_no_difference('User.count', -1) do
      delete :destroy, id: @me
    end
    assert_match(/cannot access/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
end
