require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  setup do
    @user = User.new email: 'valid.user@gmail.com',
                     avatar_url: 'lolcat.png',
                     password: 'sekret',
                     password_confirmation: 'sekret',
                     name: 'Valid User'
  end
  
  test "setup creates valid user" do
    assert @user.valid?, @user.errors.inspect
  end
  
  test "user email must be unique" do
    user = User.new email: users(:peridot).email
    
    assert user.invalid?
    assert_match(/has already been taken/, user.errors[:email].inspect)
  end
  
  test "user must have name" do
    @user.name = nil
    
    assert @user.invalid?
    assert_match(/too short/, @user.errors[:name].inspect)
  end
  
  test "user name must have more than 1 character" do
    @user.name = ""
    
    assert @user.invalid?
    assert_match(/too short/, @user.errors[:name].inspect)
  end
  
  test "user name must not have more than 28 characters" do
    @user.name = "Anna" * 8
    
    assert @user.invalid?
    assert_match(/too long/, @user.errors[:name].inspect)
  end
  
  test "user must have email" do
    @user.email = nil
    
    assert @user.invalid?
    assert_match(/too short/, @user.errors[:email].inspect)
  end
  
  test "user email must have more than 1 character" do
    @user.email = ""
    
    assert @user.invalid?
    assert_match(/too short/, @user.errors[:email].inspect)
  end
  
  test "user email must not have more than 38 characters" do
    @user.email = "anna" * 8 + "@test.com"
    
    assert @user.invalid?
    assert_match(/too long/, @user.errors[:email].inspect)
  end
  
  test "user must confirm password" do
    @user.password_confirmation = 'totally not the password'
    assert @user.invalid?
    
    assert_match(/doesn't match Password/,
                 @user.errors[:password_confirmation].inspect)
  end
  
  test "e invitations convert to invitations upon user account creation" do
    non_user_email = e_invitations(:peridot_to_x_for_birthday).email
    e_invitation_count = EInvitation.where(email: non_user_email).count
    
    assert_difference 'EInvitation.count', -e_invitation_count do
      assert_difference 'Invitation.count', e_invitation_count do
        User.create! email: non_user_email,
                     password: 'sekret',
                     password_confirmation: 'sekret',
                     name: 'Person making an account'
      end
    end
    assert_empty EInvitation.where(email: non_user_email)
  end
end
