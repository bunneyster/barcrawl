require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  
  setup do
    @tour_stop = tour_stops(:first)
    @user = users(:sam)
    login_as @user
  end
  
  test "0-click history creates 1 vote" do     
    assert_equal 0, @tour_stop.votes_from(@user).count

    assert_difference ['@tour_stop.votes_from(@user).count', '@tour_stop.reload.total_score'] do
      post :tally, tour_stop_id: @tour_stop, score: 1
    end
    
    assert_match(/Successfully voted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour))
  end

  test "same-click cancels vote" do
    assert_no_difference ['@tour_stop.votes_from(@user).count', '@tour_stop.reload.total_score'] do
      post :tally, tour_stop_id: @tour_stop, score: 1
      post :tally, tour_stop_id: @tour_stop, score: 1
    end

    assert_match(/undone/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour))
  end
  
  test "different-click cancels previous vote and creates current vote" do
    assert_difference('@tour_stop.reload.total_score') do
      post :tally, tour_stop_id: @tour_stop, score: -1    
      assert_no_difference('@tour_stop.votes_from(@user).count') do
        post :tally, tour_stop_id: @tour_stop, score: 1
      end
    end
    
    assert_match(/Successfully voted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour))
  end
  
  test "must be logged in to vote" do
    logout
    post :tally, tour_stop_id: @tour_stop, score: 1   
    assert_redirected_to root_url
  end

end
