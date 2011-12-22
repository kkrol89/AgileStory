EMAIL_CONFIG_FILE = "#{Rails.root.to_s}/config/credentials/email.yml"
$email_config = if File.exists?(EMAIL_CONFIG_FILE)
    YAML::load(File.open(EMAIL_CONFIG_FILE))
  else
    { 'smtp_user' => ENV['SMTP_USER'], 'smtp_password' => ENV['SMTP_PASSWORD'], 'smtp_address' => ENV['SMTP_ADDRESS'] }
  end

ActionMailer::Base.smtp_settings = {
  :user_name => $email_config['smtp_user'],
  :password => $email_config['smtp_password'],
  :domain => "agile-story.herokuapp.com",
  :address => $email_config['smtp_address'],
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}