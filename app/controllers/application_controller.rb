class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  helper_method :fallback
  
  def fallback(field)
    field.blank? ? "<span class='not-on-file'>Please enter...</span>".html_safe : field
  end
  
  after_filter :check_user_fields
  
  def check_user_fields
    if current_user && current_user.fields_not_filled?
      flash[:notice] = "Warning! You should <a href='#{edit_user_registration_path}'>fill in all your company details</a> to ensure the manuals contain correct information.".html_safe
    end
  end
  
end
