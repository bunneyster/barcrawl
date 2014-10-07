require 'test_helper'

class ToursControllerTest < ActionController::TestCase
  
  setup do
    @tour = tours(:birthday)
    @organizer = @tour.organizer
    @admin = users(:admin)
    @any_user = users(:not_invited_to_birthday)
  end

  test "should get index" do
    login_as @admin
    get :index
    assert_response :success
    assert_not_nil assigns(:tours)
  end

  test "should get new" do
    login_as @organizer
    get :new
    assert_response :success
  end

  test "should create tour" do
    login_as @organizer
    assert_difference('Tour.count') do
      post :create, tour: { name: 'New Tour',
                            city_id: cities(:paris).id,
                            starting_at: 1.week.from_now }
    end
    
    assert_equal @organizer, assigns(:tour).organizer
    assert_match(/Tour successfully created!/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should show tour" do
    login_as @any_user
    get :show, id: @tour
    assert_response :success
  end

  test "should get edit" do
    login_as @organizer
    get :edit, id: @tour
    assert_response :success
  end

  test "should update tour" do
    login_as @organizer
    patch :update, id: @tour, tour: { description: @tour.description }
    assert_redirected_to tour_path(assigns(:tour))
  end
  
  test "must be logged in to view tours" do
    logout
    get :show, id: @tour    
    assert_redirected_to root_url
  end
  
end
