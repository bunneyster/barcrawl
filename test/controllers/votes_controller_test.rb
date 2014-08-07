require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  
  setup do
    @upvote = votes(:up)
    @downvote = votes(:down)
    
    @tour_stop = @upvote.tour_stop
    @user = users(:sam)
    login_as @user
  end
  
  test "0-click history creates 1 vote" do     
    assert_equal 0, @tour_stop.votes_from(@user).count
    
    assert_difference [ '@tour_stop.votes_from(@user).count', '@tour_stop.total_score' ] do
      post :tally, tour_stop_id: @tour_stop.to_param, score: 1
    end
  end

  test "same-click cancels vote" do
    assert_no_difference [ '@tour_stop.votes_from(@user).count', '@tour_stop.total_score' ] do
      post :tally, tour_stop_id: @tour_stop.to_param, score: 1
      post :tally, tour_stop_id: @tour_stop.to_param, score: 1
    end
  end
  
  test "different-click cancels previous vote and creates current vote" do
    assert_difference('@tour_stop.total_score') do
      post :tally, tour_stop_id: @tour_stop.to_param, score: -1    
      assert_no_difference('@tour_stop.votes_from(@user).count') do
        post :tally, tour_stop_id: @tour_stop.to_param, score: 1
      end
    end
  end
  
  test "must be logged in to vote" do
    logout
    post :tally, tour_stop_id: @tour_stop.to_param, score: 1
    
    assert_redirected_to root_url
  end

end
