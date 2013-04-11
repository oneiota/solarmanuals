# encoding: utf-8
class SignatureMailer < ActionMailer::Base
  
  default from: "info@solarmanuals.com.au"
  
  def installer_signature_request(manual, email)
    @manual = manual
    mail(:to => email, :subject => "[Installer Technologies] Signature Request from #{manual.user.full_name}")
  end
  
end
