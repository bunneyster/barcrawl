require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  
  setup do                     
    @invitation = Invitation.new user: users(:peridot),
                                 tour: tours(:newyear)
  end

  test "setup creates valid invitation" do
    assert @invitation.valid?, @invitation.errors.inspect
  end
  
  test "invitation must belong to a user" do
    @invitation.user = nil
    
    assert @invitation.invalid?
    assert_match(/can't be blank/, @invitation.errors[:user].inspect)
  end
  
  test "invitation must belong to a tour" do
    @invitation.tour = nil
    
    assert @invitation.invalid?
    assert_match(/can't be blank/, @invitation.errors[:tour].inspect)
  end
  
  test "user can have at most 1 invitation to a tour" do
    assert @invitation.send :ensure_user_has_not_already_joined_tour    
    @invitation.save!
    
    invitation_copy = Invitation.new user: @invitation.user,
                                     tour: @invitation.tour                                       
    
    assert_not invitation_copy.save
    assert_match(/has already joined/, invitation_copy.errors[:user].inspect)
    assert_equal 1, @invitation.tour.invitations_for(users(:peridot)).count
  end
end
