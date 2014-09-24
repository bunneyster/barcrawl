require 'test_helper'

class EInvitationTest < ActiveSupport::TestCase
  setup do
    @recipient = 'non.existing.user@test.com'
    @e_invitation_for_x_to_birthday = EInvitation.new recipient: @recipient,
                                                      tour: tours(:birthday)
    @e_invitation_for_x_to_newyear = EInvitation.new recipient: @recipient,
                                                     tour: tours(:newyear)
  end
  
  test "setup creates valid e invitations" do
    assert @e_invitation_for_x_to_birthday.valid?, 
           @e_invitation_for_x_to_birthday.errors.inspect
    assert @e_invitation_for_x_to_newyear.valid?, 
           @e_invitation_for_x_to_newyear.errors.inspect
  end
  
  test "e invitation must belong to a tour" do
    @e_invitation_for_x_to_birthday.tour = nil
    
    assert @e_invitation_for_x_to_birthday.invalid?
    assert_match(/can't be blank/, 
                 @e_invitation_for_x_to_birthday.errors[:tour].inspect)
  end
  
  test "e invitation must have a recipient" do
    @e_invitation_for_x_to_birthday.recipient = nil
    
    assert @e_invitation_for_x_to_birthday.invalid?
    assert_match(/too short/, 
                 @e_invitation_for_x_to_birthday.errors[:recipient].inspect)
  end
  
  test "recipient must have more than 1 character" do
    @e_invitation_for_x_to_birthday.recipient = ""
    
    assert @e_invitation_for_x_to_birthday.invalid?
    assert_match(/too short/, 
                 @e_invitation_for_x_to_birthday.errors[:recipient].inspect)
  end
  
  test "recipient must not have more than 38 characters" do
    @e_invitation_for_x_to_birthday.recipient = "anna" * 8 + "@test.com"
    
    assert @e_invitation_for_x_to_birthday.invalid?
    assert_match(/too long/, 
                 @e_invitation_for_x_to_birthday.errors[:recipient].inspect)
  end
  
  test "recipient can get multiple e invitations, each for a different tour" do
    assert_difference('EInvitation.where(recipient: @recipient).count', 2) do
      @e_invitation_for_x_to_birthday.save!
      @e_invitation_for_x_to_newyear.save!
    end
  end
  
  test "users can't receive duplicate e invitations" do
    existing = e_invitations(:birthday_mybestfriend_at_gmail)
    duplicate = EInvitation.new recipient: existing.recipient,
                                tour: existing.tour
    
    assert duplicate.invalid?
    assert_match(/has already been e-invited/, duplicate.errors[:recipient].inspect)
  end
  
  test "users with invitations don't receive equivalent e invitations" do
    invitation = invitations(:p2birthday)   
    e_invitation = EInvitation.new recipient: invitation.user.email,
                                   tour: invitation.tour   

    assert e_invitation.invalid?
    assert_match(/recipient has already joined/, e_invitation.errors.inspect)
  end
  
  test "users with existing accounts don't receive e invitations" do
    e_invitation = EInvitation.new recipient: users(:dan).email,
                                   tour: tours(:birthday)
    
    assert e_invitation.invalid?
    assert_match(/recipient already has a user account/, e_invitation.errors[:recipient].inspect)
  end
end
