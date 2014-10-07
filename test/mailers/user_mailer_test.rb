require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @sender = users(:peridot)
    @mailer = Rails.application.secrets.gmail_email
    @user_recipient = users(:not_invited_to_birthday)
    @non_user_email = 'non.user@gmail.com'
    @tour = tours(:birthday)
    @root_url = 'hxxp://test.host:8808'
  end
  
  test "non user invitation email contents" do
    email = UserMailer.non_user_invitation_email(@sender.name,
                                                 @non_user_email,
                                                 @tour,
                                                 @root_url).deliver
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal "#{@sender.name} wants to invite you!", email.subject
    assert_equal [@mailer], email.from
    assert_equal [@non_user_email], email.to
  end
  
  test "user invitation email contents" do
    email = UserMailer.user_invitation_email(@sender,
                                             @user_recipient,
                                             @tour,
                                             @root_url).deliver
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal "#{@sender.name} wants to invite you!", email.subject
    assert_equal [@mailer], email.from
    assert_equal [@user_recipient.email], email.to
  end
end
