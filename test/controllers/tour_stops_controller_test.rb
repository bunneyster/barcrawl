require 'test_helper'

class TourStopsControllerTest < ActionController::TestCase
  setup do
    @tour_stop = tour_stops(:first)
    @tour = @tour_stop.tour
    @venue = @tour_stop.venue
    @user = users(:peridot)
    login_as @user
  end

  test "get to venue search page from tour page" do
    get :new, tour_id: @tour_stop.tour.to_param
    assert_response :success
  end
  
  test "re-proposing a venue returns to venue search results" do
    assert TourStop.where(tour: @tour, venue: @tour_stop.venue).exists?
    
    assert_no_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour.to_param,
                                 venue_id: @venue.to_param }
    end
    assert_match(/already been proposed/, flash[:notice].inspect)
    assert_redirected_to search_tour_stops_path    
  end

  test "proposing a new venue creates a tour stop with total score 1" do
    @tour_stop.destroy
    assert_not TourStop.where(tour: @tour, venue: @tour_stop.venue).exists?
       
    assert_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour.to_param, 
                                 venue_id: @venue.to_param }
    end
    assert_match(/successfully created/, flash[:notice].inspect)
    
    assert_equal 1, assigns(:tour_stop).total_score
    assert_redirected_to tour_path(assigns(:tour))
  end
  
  

  test "should update tour stop" do
    patch :update, id: @tour_stop, tour_stop: { tour_id: @tour.to_param, 
                                                venue_id: @venue.to_param }
    assert_redirected_to tour_path(assigns(:tour))
  end
  
  test "must be logged in to search for venues" do
    logout
    get :new, tour_id: @tour.to_param    
    assert_redirected_to root_url
  end
end
