ActionMailer::Base.smtp_settings = {
  :address => "smtp.mandrillapp.com",
  :port => 587,
  :domain => Rails.application.domain,
  :enable_starttls_auto => true,
  :user_name => "me@haolian.org",
  :password => "T25HLmWdlDHa6dLWFsdpAg",
  :authentication => "login",
}
