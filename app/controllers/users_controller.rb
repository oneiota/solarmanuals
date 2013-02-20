class UsersController < ApplicationController
  
  skip_before_filter :check_user_flagged!
  
  def show
    @user = User.find(params[:id])
  end
  
  # only for logo (probably)
  def update
    @user = User.find(params[:id])
    unless @user.update_attributes(params[:user])
      flash[:alert] = "There was a problem with the image, please try another."
    end
    
    # upload PDF form redirects to manual/:id
    if params[:redirect]
      redirect_to params[:redirect]
    else
      redirect_to root_url
    end
  end
  
  def edit_card
    @user = current_user
  end
  
  def update_card
    @user = current_user
    if @user.create_eway_id(params[:user])
      if @user.is_billable?
        @payment = EwayPayment.new
        @payment.user = @user
        unless @payment.process_subscription!
          flash[:alert] = "Payment failed: #{@payment.errors[:base].first}"
          redirect_to root_url and return
        end
      end
      @user.flagged = false
      @user.save
      redirect_to root_url, :notice => "Payment details updated."
    end
  end
  
  def subscribe
    @user = current_user
    @user.subscribed = true
    @user.eway_id ||= @user.create_eway_id(params[:user])
    
    # so we know to first charge them in a month
    @user.last_payed_at = Time.now
    
    @user.save
    redirect_to root_url
  end
  
  def unsubscribe
    @user = current_user
    
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