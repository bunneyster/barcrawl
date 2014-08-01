require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  
  setup do
    @invitation = invitations(:a2birthday)
    @tour = tours(:newyear)
    @user = users(:peridot)
    login_as @user
  end
  
  test "should create invitation" do
    assert_difference('Invitation.count') do
      post :create, invitation: { tour_id: @tour.to_param }
    end

    assert_match(/joined the tour/, flash[:notice])
    assert_redirected_to root_url
  end
  
  # test "failure to save redirects to tour page" do
  
  test "should destroy invitation" do
    assert_difference('Invitation.count', -1) do
      delete :destroy, id: @invitation
    end
    
    assert_match(/left the tour/, flash[:notice])
    assert_redirected_to root_url
  end

end
