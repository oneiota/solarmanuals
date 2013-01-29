class PaymentsController < ApplicationController
  rescue_from Paypal::Exception::APIError, with: :paypal_api_error

  def show
    @payment = Payment.find_by_identifier! params[:id]
  end
  
  PARAMS = {
    "single" => {
      :amount => 5,
      :digital => true,
      :recurring => false
    }
  }

  def create
    
    real_params = PARAMS[params[:payment][:type]]
    real_params[:payable_id] = params[:payment][:payable_id]
    real_params[:payable_type] = params[:payment][:payable_type]
    
    payment = Payment.create! real_params
    payment.setup!(
      success_payments_url,
      cancel_payments_url
    )
    if payment.popup?
      redirect_to payment.popup_uri
    else
      redirect_to payment.redirect_uri
    end
  end

  def destroy
    Payment.find_by_identifier!(params[:id]).unsubscribe!
    redirect_to root_path, notice: 'Recurring Profile Canceled'
  end

  def success
    handle_callback do |payment|
      payment.complete!(params[:PayerID])
      flash[:notice] = 'Payment Transaction Completed'
      success_page(payment)
    end
  end

  def cancel
    handle_callback do |payment|
      payment.cancel!
      flash[:warn] = 'Payment Request Canceled'
      root_url
    end
  end

  private
  
  def success_page(payment)
    if payment.payable_type == "Manual"
      return edit_manual_url(payment.payable_id)
    elsif payment.payable_type == "User"
      return user_url(payment.payable_id)
    end
    return root_url
  end

  def handle_callback
    payment = Payment.find_by_token! params[:token]
    @redirect_uri = yield payment
    if payment.popup?
      render :close_flow, layout: false
    else
      redirect_to @redirect_uri
    end
  end

  def paypal_api_error(e)
    redirect_to root_url, error: e.response.details.collect(&:long_message).join('<br />')
  end

end