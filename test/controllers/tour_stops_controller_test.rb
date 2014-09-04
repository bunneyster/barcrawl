require 'test_helper'

class TourStopsControllerTest < ActionController::TestCase
  setup do
    @tour_stop = tour_stops(:first)
    @tour = @tour_stop.tour
    @venue = @tour_stop.venue
    @invitee = users(:sam)
    login_as @invitee
  end

  test "get to venue search page from tour page" do
    assert @invitee.invited_to?(@tour)
    get :new, tour_id: @tour.to_param
    assert_response :success
  end
  
  test "re-proposing a venue returns to venue search results" do
    assert @invitee.invited_to?(@tour)
    
    assert_no_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour.to_param,
                                 venue_id: @venue.to_param }
    end
    assert_match(/already been proposed/, flash[:notice].inspect)
    assert_redirected_to search_tour_stops_path    
  end

  test "proposing a new venue creates a tour stop with total score 1" do
    assert @invitee.invited_to?(@tour)
    @tour_stop.destroy
    assert_not TourStop.where(tour: @tour, venue: @tour_stop.venue).exists?
       
    assert_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour.to_param, 
                                 venue_id: @venue.to_param }
    end
    assert_match(/successfully created/, flash[:notice].inspect)    
    assert_equal 1, assigns(:tour_stop).total_score
    assert_redirected_to tour_path(assigns(:tour_stop).tour)
  end  
  
  test "must be logged in to search for venues" do
    logout
    get :new, tour_id: @tour.to_param    
    assert_redirected_to root_url
  end
  
  test "uninvited users cannot propose venues" do 
    user = users(:dan)
    logout
    login_as user
    
    assert_not user.invited_to?(@tour)
    assert_no_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour.to_param, 
                                 venue_id: @venue.to_param }
    end
    assert_match(/Join the tour to propose/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "tour organizer can accept/reject tour stops" do
    user = @tour.organizer
    logout
    login_as user
    
    patch :update, id: @tour_stop, tour_stop: { status: 'yes' }
    assert_equal 'yes', assigns(:tour_stop).status
    assert_match(/successfully updated/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour_stop).tour)
  end
  
  test "non-organizer invitees cannot accept/reject tour stops" do
    assert_not @tour.organized_by?(@invitee)
    assert @invitee.invited_to?(@tour)    
    patch :update, id: @tour_stop, tour_stop: { status: 'no' }
    assert_equal 'maybe', assigns(:tour_stop).status
    assert_match(/not the organizer/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
end
