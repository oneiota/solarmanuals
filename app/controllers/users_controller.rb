class UsersController < ApplicationController
  
  skip_before_filter :check_user_flagged!
  
  rescue_from BigCharger::Error do |e|
    flash[:alert] = e.message
    redirect_to edit_card_users_path
  end
  
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
    @user.assign_attributes(params[:user])
    @user.validate_card = true    
    # validate card details
    unless @user.valid?
      render action: "edit_card" and return
    end
    
    # this should only be for users whose monthly payment failed
    if @user.create_eway_id
      if @user.flagged && @user.is_billable?
        @payment = EwayPayment.new
        @payment.user = @user
        unless @payment.process_subscription!
          flash[:alert] = "Payment failed: #{@payment.errors[:base].first}"
          redirect_to root_url and return
        end
      end
      @user.flagged = false
      @user.stored_cc_number = nil
      @user.save
      redirect_to root_url, :notice => "Payment details updated."
    else
      redirect_to root_url
    end
  end
  
  def billing
    @user = current_user
    @payments = current_user.eway_payments.reverse
    @payments_months = @payments.group_by{ |p| p.created_at.beginning_of_month }.sort.reverse!.first(12)
    
    if @payments_months.size > 0
      month = @payments_months.last.first
    
      # fill out remainder of year with empty values
      (12 - @payments_months.size).times do
        month -= 1.month
        @payments_months << [month, []]
      end
    end
  end
  
  def subscribe
    @user = current_user
  end
  
  def create_subscription
    @user = current_user
    @user.subscribed = true
    
    if params[:user]
      @user.assign_attributes(params[:user])
      @user.validate_card = true
      unless @user.valid?
        @user.subscribed = false
        flash[:alert] = "Invalid credit card"
        render action: 'subscribe' and return
      end
    end
    
    @user.eway_id ||= @user.create_eway_id
    
    # so we know to first charge them in a month
    @user.last_payed_at = Time.now
    
    @user.save
    redirect_to root_url, :notice => "You have successfully subscribed."
  end
  
  def unsubscribe
    @user = current_user
    
    unless @user.last_payed_at.nil?
      @payment = EwayPayment.new
      @payment.user = @user
      unless @payment.process_subscription!
        flash[:alert] = "Payment failed: #{@payment.errors[:base].first}. You have not been unsubscribed. Please update your credit card details and try again."
        redirect_to edit_card_users_path and return
      end
    end
    
    @user.subscribed = false
    @user.save
    redirect_to root_url, :notice => "You have unsubscribed."
  end

  def read_message
    @user = current_user
    message = Message.find(params[:message_id])
    @user.messages << message
    render nothing: true
  end
  
end