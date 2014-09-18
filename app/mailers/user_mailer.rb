class UserMailer < ActionMailer::Base
  default from: Rails.application.secrets.gmail_email
  
  def invitation_email(sender_name, recipient_email, tour, root_url)
    @sender_name = sender_name
    @tour = tour
    
    @protocol, @host = *root_url.split('://', 2)
    @host.slice!(-1) if @host[-1] == ?/    
    
    mail(to: recipient_email, subject: "#{@sender_name} wants to invite you!")
  end
end
