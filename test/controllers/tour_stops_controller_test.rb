require 'test_helper'

class TourStopsControllerTest < ActionController::TestCase
  setup do
    @tour_stop = tour_stops(:cafe_on_birthday)
    @tour = @tour_stop.tour
    @venue = @tour_stop.venue
    
    @attending = users(:accepted_invitation_to_birthday)
    @not_invited = users(:not_invited_to_birthday)
    @undecided = users(:pending_invitation_to_birthday)
  end

  test "get to venue search page from tour page" do
    login_as @attending
    get :new, tour_id: @tour.to_param
    assert_response :success
  end
  
  test "re-proposing a venue returns to venue search results" do
    login_as @attending
    assert_no_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour, venue_id: @venue }
    end
    assert_match(/already been proposed/, flash[:notice].inspect)
    assert_redirected_to search_tour_stops_path    
  end

  test "proposing a new venue creates a tour stop with total score 1" do
    login_as @attending
    @tour_stop.destroy
    assert_empty TourStop.where(tour: @tour, venue: @tour_stop.venue)
       
    assert_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour, venue_id: @venue }
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
  
  test "uninvited users can't propose venues" do 
    login_as @not_invited    
    assert_no_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour, venue_id: @venue }
    end
    assert_match(/Join the tour to propose/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "users with pending invitations can't propose venues" do 
    login_as @undecided   
    assert_no_difference('TourStop.count') do
      post :create, tour_stop: { tour_id: @tour, venue_id: @venue }
    end
    assert_match(/Join the tour to propose/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "tour organizer can accept/reject tour stops" do
    login_as @tour.organizer   
    patch :update, id: @tour_stop, tour_stop: { status: 'yes' }
    assert_equal 'yes', assigns(:tour_stop).status
    assert_match(/successfully updated/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour_stop).tour)
  end
  
  test "non-organizer users can't accept/reject tour stops" do
    login_as @attending
    refute @tour.organized_by?(@attending)
    patch :update, id: @tour_stop, tour_stop: { status: 'no' }
    assert_equal 'maybe', assigns(:tour_stop).status
    assert_match(/not the organizer/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
end
