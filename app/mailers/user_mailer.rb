# encoding: utf-8
class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  
  default from: "info@solarmanuals.com.au"
  
  def admin_payment_alert(payment)
    @payment = payment
    puts payment.return_amount
    
    mail(:to => "info@solarmanuals.com.au", :subject => "Payment Failed")
  end
  
  def payment_failed_alert(payment)
    @payment = payment
    
    mail(:to => payment.user.email, :subject => "[Installer Technologies] Payment Failed")
  end
  
  def receipt(payment)
    @payment = payment
    
    mail(:to => payment.user.email, :subject => "[Installer Technologies] Payment Receipt")
  end
  
  def welcome(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to SolarManuals.com.au")
  end
  
  
  
end
