require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  setup do
    @city = cities(:paris)
    @admin = users(:admin)
    login_as @admin
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create city" do
    assert_difference('City.count') do
      post :create, city: { latitude: @city.latitude, longitude: @city.longitude, name: @city.name }
    end

    assert_redirected_to city_path(assigns(:city))
  end

  test "should show city" do
    get :show, id: @city
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @city
    assert_response :success
  end

  test "should update city" do
    patch :update, id: @city, city: { latitude: @city.latitude, longitude: @city.longitude, name: @city.name }
    assert_redirected_to city_path(assigns(:city))
  end

  test "should destroy city" do
    assert_difference('City.count', -1) do
      delete :destroy, id: @city
    end

    assert_redirected_to cities_path
  end
  
  test "non-admins cannot access or modify city data" do
    not_admin = users(:sam)
    logout
    login_as not_admin
    
    assert_not not_admin.admin?
    get :new
    assert_match(/must be an admin/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
end
