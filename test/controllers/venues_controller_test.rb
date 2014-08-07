require 'test_helper'

class VenuesControllerTest < ActionController::TestCase
  fixtures :cities
    
  setup do
    @venue = venues(:cafe)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venue" do
    assert_difference('Venue.count') do
      post :create, venue: { name: 'Pasta Palace',
                             city_id: @venue.city_id,
                             cid: 24680,
                             latitude: @venue.latitude,
                             longitude: @venue.longitude }
    end

    assert_redirected_to venue_path(assigns(:venue))
  end

  test "should show venue" do
    get :show, id: @venue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @venue
    assert_response :success
  end

  test "should update venue" do
    patch :update, id: @venue, venue: { name: @venue.name }
    assert_redirected_to venue_path(assigns(:venue))
  end

  test "venue should only be destroyed if not referenced by tour stops" do
    assert_no_difference('Venue.count', -1) do
      delete :destroy, id: @venue
    end
    
    TourStop.where(venue: @venue).destroy_all
    
    assert_difference('Venue.count', -1) do
      delete :destroy, id: @venue
    end    

    assert_redirected_to venues_path
  end
end
