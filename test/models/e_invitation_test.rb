require 'test_helper'

class EInvitationTest < ActiveSupport::TestCase
  setup do
    @e_invitation = EInvitation.new sender: users(:peridot),
                                    recipient: 'recipient@gmail.com',
                                    tour: tours(:birthday)
  end
  
  test "setup creates valid e invitation" do
    assert @e_invitation.valid?, @e_invitation.errors.inspect
  end
  
  test "e invitation must belong to a sender" do
    @e_invitation.sender = nil
    
    assert @e_invitation.invalid?
    assert_match(/can't be blank/, @e_invitation.errors[:sender].inspect)
  end
  
  test "e invitation must belong to a tour" do
    @e_invitation.tour = nil
    
    assert @e_invitation.invalid?
    assert_match(/can't be blank/, @e_invitation.errors[:tour].inspect)
  end
  
  test "e invitation must have a recipient" do
    @e_invitation.recipient = nil
    
    assert @e_invitation.invalid?
    assert_match(/too short/, @e_invitation.errors[:recipient].inspect)
  end
  
  test "recipient must have more than 1 character" do
    @e_invitation.recipient = ""
    
    assert @e_invitation.invalid?
    assert_match(/too short/, @e_invitation.errors[:recipient].inspect)
  end
  
  test "recipient must not have more than 38 characters" do
    @e_invitation.recipient = "anna" * 8 + "@test.com"
    
    assert @e_invitation.invalid?
    assert_match(/too long/, @e_invitation.errors[:recipient].inspect)
  end
  
  test "recipient receives at most 1 e invitation per tour" do
    e_invitation = EInvitation.new recipient: e_invitations(:one).recipient,
                                   tour: e_invitations(:one).tour
    
    assert e_invitation.invalid?
    assert_match(/has already been invited/, e_invitation.errors[:recipient].inspect)
  end
  
  test "tour participants do not receive e invitations for that tour" do
    invitation = invitations(:p2birthday)
    recipient = invitation.user.email
    tour = invitation.tour        
    e_invitation = EInvitation.new sender: users(:sam),
                                   recipient: recipient,
                                   tour: tour

    # e_invitation.save!
    assert e_invitation.invalid?
    assert_match(/recipient has already joined/, e_invitation.errors.inspect)
    assert tour.e_invitations.where(recipient: recipient).empty?
  end
end