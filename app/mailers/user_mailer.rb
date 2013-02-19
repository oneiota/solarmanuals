class UserMailer < ActionMailer::Base
  default from: "info@solarmanuals.com.au"
  
  def test
    mail(:to => "tom@conroy.com.au", :subject => "Test")
  end
  
end
