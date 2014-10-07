require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  
  setup do                     
    @invitation = Invitation.new sender: users(:peridot),
                                 recipient: users(:not_invited_to_birthday),
                                 tour: tours(:birthday)
  end

  test "setup creates valid invitation" do
    assert @invitation.valid?, @invitation.errors.inspect
  end
  
  test "invitation must belong to a user" do
    @invitation.recipient = nil
    
    assert @invitation.invalid?
    assert_match(/can't be blank/, @invitation.errors[:recipient].inspect)
  end
  
  test "invitation must belong to a tour" do
    @invitation.tour = nil
    
    assert @invitation.invalid?
    assert_match(/can't be blank/, @invitation.errors[:tour].inspect)
  end
  
  test "users can't receive duplicate invitations" do
    @invitation.save!
    
    invitation_copy = Invitation.new sender: users(:not_peridot),
                                     recipient: @invitation.recipient,
                                     tour: @invitation.tour                                       
    
    assert invitation_copy.invalid?
    assert_match(/has already been invited/, invitation_copy.errors[:recipient].inspect)
  end
end
