class PaymentsController < ApplicationController
  rescue_from Paypal::Exception::APIError, with: :paypal_api_error

  def show
    @payment = Payment.find_by_identifier! params[:id]
  end
  
  SETTINGS = {
    "single" => {
      :amount => 5,
      :digital => true,
      :recurring => false
    },
    "subscription" => {
      :amount => 30,
      :digital => true,
      :recurring => true
    }
  }

  def create
    payment_params = SETTINGS[params[:payment][:type]]
    payment_params[:payable_id] = params[:payment][:payable_id]
    payment_params[:payable_type] = params[:payment][:payable_type]
    
    payment = Payment.create! payment_params
    payment.setup!(
      success_payments_url,
      cancel_payments_url
    )
    puts payment.inspect
    puts "REDIRECT URI: #{payment.redirect_uri}"
    if payment.popup?
      redirect_to payment.popup_uri
    else
      redirect_to payment.redirect_uri
    end
  end
  
  # for when a user clicks "Pay" after already clicking Pay once and not paying
  # since the Payment entry is created, we need to setup and redirect again
  # but we already have the details stored
  def update
    payment = Payment.find(params[:id])
    payment.setup!(
      success_payments_url,
      cancel_payments_url
    )
    puts payment.inspect
    if payment.popup?
      redirect_to payment.popup_uri
    else
      redirect_to payment.redirect_uri
    end
  end

  def destroy
    Payment.find_by_id(params[:id]).unsubscribe!
    redirect_to root_path, notice: 'Subscription successfully cancelled'
  end

  def success
    handle_callback do |payment|
      payment.complete!(params[:PayerID])
      flash[:notice] = 'Payment was successful'
      success_page(payment)
    end
  end

  def cancel
    handle_callback do |payment|
      payment.cancel!
      flash[:warn] = 'Payment cancelled'
      root_url
    end
  end

  private
  
  def success_page(payment)
    if payment.payable_type == "Manual"
      return edit_manual_url(payment.payable_id)
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