require 'test_helper'

class EInvitationsControllerTest < ActionController::TestCase
  setup do
    ActionMailer::Base.deliveries.clear
    @tour = tours(:birthday)
    
    @attending = @tour.attendees.first!
    @not_invited = users(:not_invited_to_birthday)
    @undecided = users(:pending_invitation_to_birthday)
    @admin = users(:admin)
  end

  test "users with pending invitations can't view new invitation form" do
    login_as @undecided
    get :new, tour_id: @tour.to_param
    assert_match(/Join the tour/, flash[:notice].inspect)
    assert_redirected_to root_url
  end
  
  test "users with accepted invitations can view new invitation form" do
    login_as @attending
    get :new, tour_id: @tour
    assert_response :success
  end
  
  test "users with pending invitations can't send invitations via email" do
    login_as @undecided
    assert_no_difference ['Invitation.count', 'EInvitation.count'] do
      post :create, e_invitation: { email: @not_invited.email,
                                    tour_id: @tour }
    end
    assert_nil assigns(:invitation)
    assert_nil assigns(:e_invitation)
    assert_empty ActionMailer::Base.deliveries
    assert_redirected_to root_url
  end
  
  test "inviting a user via email generates a pending Invitation" do
    login_as @attending
    assert_difference 'Invitation.count' do
      post :create, e_invitation: { email: @not_invited.email,
                                    tour_id: @tour }
    end
    assert_equal 'pending', assigns(:invitation).status
    assert_equal @attending, assigns(:invitation).sender
    assert_equal @not_invited, assigns(:invitation).recipient
    assert_equal @tour, assigns(:invitation).tour
    assert_nil assigns(:e_invitation)
    refute_empty ActionMailer::Base.deliveries
    assert_redirected_to tour_path(assigns(:tour))
  end
  
  test "inviting a non-user via email generates an EInvitation" do
    login_as @attending
    assert_difference 'EInvitation.count' do
      post :create, e_invitation: { email: 'no_user_account@asdf.com',
                                    tour_id: @tour }
    end
    assert_equal @attending, assigns(:e_invitation).sender
    assert_equal 'no_user_account@asdf.com', assigns(:e_invitation).email
    assert_equal @tour, assigns(:e_invitation).tour
    assert_nil assigns(:invitation)
    refute_empty ActionMailer::Base.deliveries
    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should destroy e_invitation" do
    login_as @admin
    @e_invitation = e_invitations(:peridot_to_x_for_birthday)
    assert_difference('EInvitation.count', -1) do
      delete :destroy, id: @e_invitation
    end
    assert_redirected_to root_url
  end
end
