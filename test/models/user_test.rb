require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  setup do
    @user = User.new email: 'newuser@gmail.com',
                     avatar_url: 'lolcat.png',
                     password: 'sekret',
                     password_confirmation: 'sekret',
                     name: 'newuser'
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
    assert_match(/can't be blank/, @user.errors[:name].inspect)
  end
  
  test "user must have email" do
    @user.email = nil
    
    assert @user.invalid?
    assert_match(/can't be blank/, @user.errors[:email].inspect)
  end
  
  test "user must confirm password" do
    @user.password_confirmation = 'totally not the password'
    assert @user.invalid?
    
    assert_match(/doesn't match Password/,
                 @user.errors[:password_confirmation].inspect)
  end
end
