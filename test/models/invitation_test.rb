require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  
  setup do
    @tour = Tour.new name: "Valid Tour",
                     organizer: users(:sam),
                     city: tours(:newyear).city,
                     starting_at: 1.week.from_now
                     
    @invitation = Invitation.new user: users(:peridot),
                                 tour: @tour
  end

  test "setup creates valid tour" do
    assert @tour.valid?, @tour.errors.inspect
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
    @tour.save!
    assert @invitation.send :ensure_user_has_not_already_joined_tour    
    @invitation.save!
    
    invitation_copy = Invitation.new user: @invitation.user,
                                     tour: @invitation.tour                                       
    assert_not invitation_copy.send :ensure_user_has_not_already_joined_tour
    assert_not invitation_copy.save
    
    assert_equal 1, @tour.invitation_for(users(:peridot)).count
  end
end
