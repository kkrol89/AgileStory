# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SMTP_USER'],
  :password => ENV['SMTP_PASSWORD'],
  :domain => "cold-leaf-1834.heroku.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# Initialize the rails application
Zumba::Application.initialize!
