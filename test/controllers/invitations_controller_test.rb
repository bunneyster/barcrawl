require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  
  setup do
    @tour = tours(:birthday)
    @participant = @tour.organizer
    
    @invitation = invitations(:a2birthday)
    @invited_user = @invitation.user
    
    @uninvited_user = users(:dan)
  end
  
  test "existing users without invitations receive pending invitations" do
    login_as @participant
    
    assert_not @tour.invitation_for(@uninvited_user)    
    assert_difference('Invitation.count') do
      post :create, invitation: { user_id: @uninvited_user.to_param,
                                  tour_id: @tour.to_param }
    end
    assert_equal 'pending', assigns(:invitation).status
    assert_match(/joined the tour/, flash[:notice].inspect)
    assert_redirected_to @tour
  end
  
  # test "failure to save redirects to tour page"
  
  test "existing users with pending invitations can join the tour" do
    login_as @invited_user
    
    assert @tour.invitation_for(@invited_user)    
    
    patch :update, id: @invitation, invitation: { status: 'accepted' }
    
    assert_match(/accepted/, flash[:notice].inspect)
    assert_redirected_to @tour
  end
  
  test "must be logged in to send/accept/reject invitations" do
    login_as @participant
    logout
    assert_not @tour.invitation_for(@uninvited_user)
    post :create, invitation: { user_id: @uninvited_user.to_param,
                                tour_id: @tour.to_param }
    assert_redirected_to root_url
  end

end
