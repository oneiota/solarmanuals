ActionMailer::Base.smtp_settings = {
  :address  => "mail.solarmanuals.com.au",
  :port  => 587,
  :user_name  => "info@solarmanuals.com.au",
  :password  => "+oEzv7;utEo4",
  :authentication  => :plain,
  :enable_starttls_auto => true,
  :openssl_verify_mode  => 'none'
}


ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true