require 'test_helper'

class EInvitationsControllerTest < ActionController::TestCase
  setup do
    @e_invitation = e_invitations(:peridot_birthday_mybestfriend_at_gmail)
    @any_user = users(:sam)
    @admin = users(:admin)
  end

  test "should get index" do
    login_as @admin
    get :index
    assert_response :success
    assert_not_nil assigns(:e_invitations)
  end

  test "should get new" do
    login_as @any_user
    get :new, tour_id: @e_invitation.tour.to_param
    assert_response :success
  end

  test "should create e_invitation" do
    login_as @any_user
    assert_difference('EInvitation.count') do
      post :create, e_invitation: { recipient: 'new_recipient@gmail.com',
                                    tour_id: @e_invitation.tour_id }
    end
    
    assert_equal @any_user, assigns(:e_invitation).sender
    assert_redirected_to tour_path(assigns(:e_invitation).tour)
  end

  test "should show e_invitation" do
    login_as @admin
    get :show, id: @e_invitation
    assert_response :success
  end

  test "should update e_invitation" do
    login_as @admin
    patch :update, id: @e_invitation, e_invitation: { recipient: @e_invitation.recipient, sender_id: @e_invitation.sender_id, tour_id: @e_invitation.tour_id }
    assert_redirected_to e_invitation_path(assigns(:e_invitation))
  end

  test "should destroy e_invitation" do
    login_as @admin
    assert_difference('EInvitation.count', -1) do
      delete :destroy, id: @e_invitation
    end

    assert_redirected_to e_invitations_path
  end
end
