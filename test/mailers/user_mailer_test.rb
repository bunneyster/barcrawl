require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @mailer = Rails.application.secrets.gmail_email
    @e_invitation = e_invitations(:peridot_to_x_for_birthday)
    @invitation = invitations(:accepted2birthday)
    @root_url = 'hxxp://test.host:8808'
  end
  
  test "non user invitation email contents" do
    email = UserMailer.non_user_invitation_email(@e_invitation, @root_url).deliver
    assert !ActionMailer::Base.deliveries.empty?    
    assert_equal "#{@e_invitation.sender.name} wants to invite you!", email.subject
    assert_equal [@mailer], email.from
    assert_equal [@e_invitation.email], email.to
  end
  
  test "user invitation email contents" do
    email = UserMailer.user_invitation_email(@invitation, @root_url).deliver
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal "#{@invitation.sender.name} wants to invite you!", email.subject
    assert_equal [@mailer], email.from
    assert_equal [@invitation.recipient.email], email.to
  end
end
