require 'test_helper'

class TourStopsControllerTest < ActionController::TestCase
  setup do
    @tour_stop = tour_stops(:first)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tour_stops)
  end

  test "get to venue selection page from tour page" do
    get :new, tour_id: @tour_stop.tour.id
    assert_response :success
  end

  test "should create tour stop only if venue has not already been proposed" do
    assert TourStop.where(tour: @tour_stop.tour, venue: @tour_stop.venue).exists?
    
    assert_no_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour_stop.tour_id, venue_id: @tour_stop.venue_id }
    end

    @tour_stop.destroy
        
    assert_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour_stop.tour_id, venue_id: @tour_stop.venue_id }
    end

    assert_match(/successfully created/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should show tour_stop" do
    get :show, id: @tour_stop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tour_stop
    assert_response :success
  end

  test "should update tour_stop" do
    patch :update, id: @tour_stop, tour_stop: { tour_id: @tour_stop.tour_id, venue_id: @tour_stop.venue_id }
    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should destroy tour_stop" do
    assert_difference('TourStop.count', -1) do
      delete :destroy, id: @tour_stop
    end

    assert_redirected_to tour_stops_path
  end
end
