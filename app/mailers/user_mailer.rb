class UserMailer < ActionMailer::Base
  default from: Rails.application.secrets.gmail_email
  
  def non_user_invitation_email(e_invitation, root_url)
    @sender_name = e_invitation.sender.name
    @tour = e_invitation.tour
    
    @protocol, @host = *root_url.split('://', 2)
    @host.slice!(-1) if @host[-1] == ?/    
    
    mail(to: e_invitation.email, subject: "#{@sender_name} wants to invite you!")
  end
  
  def user_invitation_email(invitation, root_url)
    @sender = invitation.sender
    @recipient = invitation.recipient
    @tour = invitation.tour
    
    @protocol, @host = *root_url.split('://', 2)
    @host.slice!(-1) if @host[-1] == ?/    
    
    mail(to: @recipient.email, subject: "#{@sender.name} wants to invite you!")
  end
end
