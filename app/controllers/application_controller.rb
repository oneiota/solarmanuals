class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  helper_method :fallback
  
  def fallback(field)
    field.blank? ? "<span class='not-on-file'>Please enter...</span>".html_safe : field
  end
  
  
end
