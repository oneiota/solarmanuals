class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :devise_layouts
  
  def devise_layouts
    (devise_controller? && action_name == 'new') ? 'home' : 'application'
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  helper_method :fallback
  
  def fallback(field)
    field.blank? ? "<span class='not-on-file'>Please enter...</span>".html_safe : field
  end
  
  before_filter :check_user_flagged!
  
  def check_user_flagged!
    if current_user && current_user.flagged
      flash[:alert] ||= "Your last payment failed. Please update your credit card details."
      render "users/edit_card"
    end
  end
  
end
