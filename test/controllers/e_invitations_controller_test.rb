require 'test_helper'

class EInvitationsControllerTest < ActionController::TestCase
  setup do
    ActionMailer::Base.deliveries.clear
    @tour = tours(:birthday)
    
    @attending = users(:accepted_invitation_to_birthday)
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
    assert_empty ActionMailer::Base.deliveries
    assert_redirected_to root_url
  end
  
  test "inviting an uninvited user via email generates a pending Invitation" do
    login_as @attending
    assert_difference 'Invitation.count' do
      post :create, e_invitation: { email: @not_invited.email, tour_id: @tour }
    end
    refute_empty ActionMailer::Base.deliveries
    assert_redirected_to tour_path(@tour)
  end
  
  test "inviting an uninvited non-user via email generates an EInvitation" do
    login_as @attending
    assert_difference 'EInvitation.count' do
      post :create, e_invitation: { email: 'no_user_account@asdf.com',
                                    tour_id: @tour }
    end
    assert_equal @attending, assigns(:e_invitation).sender
    assert_equal 'no_user_account@asdf.com', assigns(:e_invitation).email
    assert_equal @tour, assigns(:e_invitation).tour
    refute_empty ActionMailer::Base.deliveries
    assert_redirected_to @tour
  end
  
  test "inviting an invited user via email generates a validation error" do
    login_as @attending
    assert_no_difference ['Invitation.count', 'EInvitation.count'] do
      post :create, e_invitation: { email: @undecided.email, tour_id: @tour }
    end 
    assert_match(/already has a user account/, assigns(:e_invitation).errors[:email].inspect)
    assert_match(/has already been invited/, assigns(:e_invitation).errors[:email].inspect)
    assert_template :new
  end
  
  test "inviting an invited non-user via email generates a validation error" do
    login_as @attending
    invited_non_user_email = e_invitations(:peridot_to_x_for_birthday).email
    assert_no_difference ['Invitation.count', 'EInvitation.count'] do
      post :create, e_invitation: { email: invited_non_user_email,
                                    tour_id: tours(:birthday) }
    end
    assert_match(/has already been e-invited/, assigns(:e_invitation).errors[:email].inspect)
    assert_template :new
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
