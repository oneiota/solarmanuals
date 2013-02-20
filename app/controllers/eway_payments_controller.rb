class EwayPaymentsController < ApplicationController
  
  layout "invoice", :only => [:show]
  
  rescue_from BigCharger::Error do |e|
    redirect_to :back, :alert => e.inspect
  end
  
  def show
    @payment = EwayPayment.find(params[:id])
  end
  
  # casual payment
  def create
    
    if params[:manual_id]
      @manual = Manual.find(params[:manual_id])
    end
    
    @payment = EwayPayment.new(params[:payment])
    @user = current_user
    @payment.user = @user
    
    @user.eway_id ||= @user.create_eway_id(params[:eway_payment])
    
    @payment.process_payment!(CASUAL_FEE)
    
    if @payment.save
      if @manual
        @manual.eway_payment = @payment
        @manual.save
        
        # email receipt
        UserMailer.receipt(@payment).deliver
        
        redirect_to @manual, :notice => "Payment processed succesfully."
      end
    else
      redirect_to @manual, :alert => "Payment failed: #{@payment.errors[:base].first}"
    end
    
  end
  
end