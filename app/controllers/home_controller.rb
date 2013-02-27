

class HomeController < ApplicationController
  
  layout "home"
  
  skip_before_filter :check_user_flagged!
  
  def index; end 
  def faq; end
  def terms; end  
  def privacy; end
  def refunds; end
  def delivery; end

  
end