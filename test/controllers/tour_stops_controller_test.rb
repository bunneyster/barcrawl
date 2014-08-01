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

  test "should create tour_stop" do
    assert_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour_stop.tour_id, venue_id: @tour_stop.venue_id }
    end

    assert_redirected_to tour_path(assigns(:current_tour))
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
    assert_redirected_to tour_stop_path(assigns(:tour_stop))
  end

  test "should destroy tour_stop" do
    assert_difference('TourStop.count', -1) do
      delete :destroy, id: @tour_stop
    end

    assert_redirected_to tour_stops_path
  end
end
