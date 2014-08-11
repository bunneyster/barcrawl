require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  
  setup do
    @tour = tours(:birthday)
    @invitation = invitations(:a2birthday)
    @invited_user = users(:allison)
    @uninvited_user = users(:dan)
  end
  
  test "join a tour" do
    login_as @uninvited_user
    assert_not @tour.invitation_for(@user).exists?
    
    assert_difference('Invitation.count') do
      post :create, invitation: { tour_id: @tour.to_param }
    end

    assert_match(/joined the tour/, flash[:notice].inspect)
    assert_redirected_to @tour
  end
  
  # test "failure to save redirects to tour page"
  
  test "leave a tour" do
    login_as @invited_user
    assert @tour.invitation_for(@invited_user).exists?
    
    assert_difference('Invitation.count', -1) do
      delete :destroy, id: @invitation, invitation: {tour_id: @tour.to_param}
    end
    
    assert_match(/left the tour/, flash[:notice].inspect)
    assert_redirected_to @tour
  end
  
  test "must be logged in to join tours" do
    login_as @uninvited_user
    logout
    assert_not @tour.invitation_for(@user).exists?
    post :create, invitation: { tour_id: @tour.to_param }
    assert_redirected_to root_url
  end

end
