class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :devise_layouts
  
  def devise_layouts
    (devise_controller? && %w{create new}.include?(action_name)) ? 'home' : 'application'
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  helper_method :fallback
  
  helper_method :get_notices
  
  def fallback(field)
    field.blank? ? "<span class='not-on-file'>Please enter...</span>".html_safe : field
  end
  
  before_filter :check_user_flagged!
  
  def check_user_flagged!
    if current_user
      if current_user.flagged
        flash[:alert] ||= "Your last payment failed. Please update your credit card details."
        render "users/edit_card"
      elsif current_user.subscribed && current_user.eway_id == nil
        flash[:alert] ||= "Payment details couldn't be found. Please re-enter them"
        render "users/edit_card"
      end
    end
  end
  
  def get_notices
    
    notices = {}
    
    if current_user
      notices = current_user.flash_message || {}
    end
    
    f = flash.to_hash || {}
    f.each do |name, msg|
      f[name] = [nil, msg]
    end
        
    notices.merge(f)

  end
    
end
