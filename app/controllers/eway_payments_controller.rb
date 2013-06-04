class EwayPaymentsController < ApplicationController
  
  layout "invoice", :only => [:show]
  before_filter :authenticate_user!
  def show
    @payment = EwayPayment.find(params[:id])
  end
  
  # casual payment
  def create

  end
  
end