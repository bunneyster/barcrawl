require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @sender_name = 'Peridot'
    @sender_email = Rails.application.secrets.gmail_email
    @recipient_email = 'mybestfriend@gmail.com'
    @tour = tours(:birthday)
    @root_url = 'hxxp://test.host:8808'
  end
  test "invitation email contents" do
    email = UserMailer.invitation_email(@sender_name,
                                        @recipient_email,
                                        @tour,
                                        @root_url).deliver
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal "#{@sender_name} wants to invite you!", email.subject
    assert_equal [@sender_email], email.from
    assert_equal [@recipient_email], email.to
  end
end
