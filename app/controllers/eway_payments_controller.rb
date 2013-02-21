class EwayPaymentsController < ApplicationController
  
  layout "invoice", :only => [:show]
  
  def show
    @payment = EwayPayment.find(params[:id])
  end
  
  # casual payment
  def create

  end
  
end