if Rails.env.production?
  Seven::Application.config.middleware.use ExceptionNotification::Rack,
      email: {
        email_prefix: "[crash] ",
        sender_address: Rails.application.secrets.gmail_email,
        exception_recipients: Rails.application.secrets.gmail_email
      }
end