require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  
  setup do
    ActionMailer::Base.deliveries.clear
    @tour = tours(:birthday)
    
    @attending = users(:accepted_invitation_to_birthday)
    @not_invited = users(:not_invited_to_birthday)
    @undecided = users(:pending_invitation_to_birthday)
    
  end
  
  test "must accept invitation to send invitations via friendship" do
    login_as @undecided
    assert_no_difference ['Invitation.count', 'EInvitation.count'] do
      post :create, invitation: { recipient_id: @not_invited, tour_id: @tour }
    end
    assert_empty ActionMailer::Base.deliveries
    assert_redirected_to root_url
  end
  
  test "inviting a user via friendship generates a pending Invitation" do
    login_as @attending 
    assert_difference ['Invitation.count', 'ActionMailer::Base.deliveries.count'] do
      post :create, invitation: { recipient_id: @not_invited, tour_id: @tour }
    end
    assert_equal 'pending', assigns(:invitation).status
    assert_equal @attending, assigns(:invitation).sender
    assert_equal @not_invited, assigns(:invitation).recipient
    assert_equal @tour, assigns(:invitation).tour
    assert_redirected_to @tour
  end
    
  test "users with pending invitations can join the tour" do
    login_as @undecided
    @invitation = invitations(:pending2birthday)
    patch :update, id: @invitation, invitation: { status: 'accepted' }    
    assert_match(/accepted/, flash[:notice].inspect)
    assert_redirected_to @tour
  end
  
  test "must be logged in to send/accept/reject invitations" do
    login_as @attending
    logout
    post :create, invitation: { recipient_id: @not_invited, tour_id: @tour }
    assert_redirected_to root_url
  end
end
