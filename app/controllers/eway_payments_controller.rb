class EwayPaymentsController < ApplicationController
  
  layout "invoice", :only => [:show]
  
  rescue_from BigCharger::Error do |e|
    redirect_to :back, :alert => "Payment details were invalid."
  end
  
  def show
    @payment = EwayPayment.find(params[:id])
  end
  
  def create
    
    if params[:manual_id]
      @manual = Manual.find(params[:manual_id])
    end
    
    @payment = EwayPayment.new(params[:payment])
    @user = current_user
    @payment.user = @user
    
    eway_id = @user.eway_id || @user.create_eway_id(params[:eway_payment])
    
    response = Eway.client.process_payment(
      eway_id,
      500,
      'Solar Manuals'
    )
    
    @payment.eway_error = response['ewayTrxnError']
    @payment.eway_status = response['ewayTrxnStatus']
    @payment.transaction_number = response['ewayTrxnNumber']
    @payment.return_amount = response['ewayReturnAmount']
    @payment.eway_auth_code = response['ewayAuthCode']
    
    if @payment.save
      if @manual
        @manual.eway_payment = @payment
        @manual.save
        redirect_to @manual
      end
    end
    
  end
  
end