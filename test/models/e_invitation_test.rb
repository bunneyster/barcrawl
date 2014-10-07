require 'test_helper'

class EInvitationTest < ActiveSupport::TestCase
  setup do
    @email = 'non.existing.user@test.com'
    @e_invitation_for_x_to_birthday = EInvitation.new sender: users(:peridot),
        email: @email, tour: tours(:birthday)
    @e_invitation_for_x_to_newyear = 
        EInvitation.new sender: users(:newyear_organizer), email: @email, 
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
  
  test "e invitation must have a email" do
    @e_invitation_for_x_to_birthday.email = nil
    
    assert @e_invitation_for_x_to_birthday.invalid?
    assert_match(/too short/, 
                 @e_invitation_for_x_to_birthday.errors[:email].inspect)
  end
  
  test "email must have more than 1 character" do
    @e_invitation_for_x_to_birthday.email = ""
    
    assert @e_invitation_for_x_to_birthday.invalid?
    assert_match(/too short/, 
                 @e_invitation_for_x_to_birthday.errors[:email].inspect)
  end
  
  test "email must not have more than 38 characters" do
    @e_invitation_for_x_to_birthday.email = "anna" * 8 + "@test.com"
    
    assert @e_invitation_for_x_to_birthday.invalid?
    assert_match(/too long/, 
                 @e_invitation_for_x_to_birthday.errors[:email].inspect)
  end
  
  test "email can get multiple e invitations, each for a different tour" do
    assert_difference('EInvitation.where(email: @email).count', 2) do
      @e_invitation_for_x_to_birthday.save!
      @e_invitation_for_x_to_newyear.save!
    end
  end
  
  test "users can't receive duplicate e invitations" do
    existing = e_invitations(:peridot_to_x_for_birthday)
    duplicate = EInvitation.new email: existing.email,
                                tour: existing.tour
    
    assert duplicate.invalid?
    assert_match(/has already been e-invited/, duplicate.errors[:email].inspect)
  end
  
  test "users with existing accounts don't receive e invitations" do
    e_invitation = EInvitation.new sender: users(:peridot),
                                   email: users(:not_invited_to_birthday).email,
                                   tour: tours(:birthday)
    
    assert e_invitation.invalid?
    assert_match(/already has a user account/, e_invitation.errors[:email].inspect)
  end
end
