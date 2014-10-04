class UserMailer < ActionMailer::Base
  default from: Rails.application.secrets.gmail_email
  
  def non_user_invitation_email(sender_name, recipient_email, tour, root_url)
    @sender_name = sender_name
    @tour = tour
    
    @protocol, @host = *root_url.split('://', 2)
    @host.slice!(-1) if @host[-1] == ?/    
    
    mail(to: recipient_email, subject: "#{@sender_name} wants to invite you!")
  end
  
  def user_invitation_email(sender, recipient, tour, root_url)
    @sender = sender
    @recipient = recipient
    @tour = tour
    
    @protocol, @host = *root_url.split('://', 2)
    @host.slice!(-1) if @host[-1] == ?/    
    
    mail(to: @recipient.email, subject: "#{@sender.name} wants to invite you!")
  end
end
