class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  # only for logo (probably)
  def update
    @user = User.find(params[:id])
    unless @user.update_attributes(params[:user])
      flash[:alert] = "Please use an image under 2MB"
    end
    
    # upload PDF form redirects to manual/:id
    if params[:redirect]
      redirect_to params[:redirect]
    else
      redirect_to root_url
    end
  end
  
  def subscribe
    @user = User.find(params[:user_id])
    @user.subscribed = true
    @user.eway_id ||= @user.create_eway_id(params[:user])
    puts @user.eway_id
    @user.save
    redirect_to root_url
  end
  
  def unsubscribe
    @user = User.find(params[:user_id])
    
    unless @user.last_payed_at.nil?
      @payment = EwayPayment.new
      @payment.user = @user
      @payment.process_unsubscribe_payment!
    end
    
    @user.subscribed = false
    @user.save
    redirect_to root_url
  end
  
end