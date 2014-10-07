require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  
  setup do
    @tour_stop = tour_stops(:cafe_on_birthday)
    @user = users(:accepted_invitation_to_birthday)
    login_as @user
  end
  
  test "0-click history creates 1 vote" do     
    assert @user.invited_to?(@tour_stop.tour)
    assert_equal 0, @tour_stop.votes_from(@user).count

    assert_difference ['@tour_stop.votes_from(@user).count', '@tour_stop.reload.total_score'] do
      post :tally, tour_stop_id: @tour_stop, score: 1
    end
    
    assert_match(/Successfully voted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour_stop).tour)
  end

  test "same-click cancels vote" do
    assert @user.invited_to?(@tour_stop.tour)
    assert_no_difference ['@tour_stop.votes_from(@user).count', '@tour_stop.reload.total_score'] do
      post :tally, tour_stop_id: @tour_stop, score: 1
      post :tally, tour_stop_id: @tour_stop, score: 1
    end

    assert_match(/undone/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour_stop).tour)
  end
  
  test "different-click cancels previous vote and creates current vote" do
    assert @user.invited_to?(@tour_stop.tour)
    assert_difference('@tour_stop.reload.total_score') do
      post :tally, tour_stop_id: @tour_stop, score: -1    
      assert_no_difference('@tour_stop.votes_from(@user).count') do
        post :tally, tour_stop_id: @tour_stop, score: 1
      end
    end
    
    assert_match(/Successfully voted/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour_stop).tour)
  end
  
  test "must be logged in to vote" do
    logout
    post :tally, tour_stop_id: @tour_stop, score: 1   
    assert_redirected_to root_url
  end
  
  test "must join tour to vote on venue proposals" do
    user = users(:not_invited_to_birthday)
    logout
    login_as user
    
    assert_not user.invited_to?(@tour_stop.tour)    
    assert_no_difference [ '@tour_stop.votes_from(@user).count', '@tour_stop.reload.total_score' ] do
      post :tally, tour_stop_id: @tour_stop, score: 1
    end    
    assert_match(/Join the tour to vote/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour_stop).tour)
  end
  
  test "invalid vote scores are cancelled" do
    assert @user.invited_to?(@tour_stop.tour)
    assert_no_difference ['@tour_stop.votes_from(@user).count', '@tour_stop.reload.total_score'] do
      post :tally, tour_stop_id: @tour_stop, score: 20
    end
    
    assert_match(/Stop/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour_stop).tour)
  end
  
  test "cannot vote on finalized tours" do
    finalized_tour = tours(:anniversary)
    tour_stop = tour_stops(:finalized)
    user = users(:accepted_invitation_to_anniversary)
    logout
    login_as user
    
    assert user.attending?(finalized_tour)
    assert_no_difference ['tour_stop.votes_from(@user).count', 'tour_stop.reload.total_score'] do
      post :tally, tour_stop_id: tour_stop, score: 1
    end
    
    assert_match(/Voting for this tour has ended/, flash[:notice].inspect)
    assert_redirected_to tour_path(assigns(:tour_stop).tour)
  end

end
