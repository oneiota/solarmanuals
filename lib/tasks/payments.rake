namespace :solar do
  
  task :run_payments => :environment do
    
    User.where('last_payed_at <= ? OR last_payed_at IS NULL', 1.minute.ago).each do |user|
      
      
      @payment = EwayPayment.new
      @payment.user = user
      
      charge_amount = user.current_charge
      
      next if charge_amount == 0
      
      response = Eway.client.process_payment(
        user.eway_id,
        charge_amount,
        'Solar Manuals'
      )
      
      @payment.eway_error = response['ewayTrxnError']
      @payment.eway_status = response['ewayTrxnStatus']
      @payment.transaction_number = response['ewayTrxnNumber']
      @payment.return_amount = response['ewayReturnAmount']
      @payment.eway_auth_code = response['ewayAuthCode']
      
      if @payment.save
        puts "Created payment for #{user.first_name} #{user.last_name} at #{charge_amount}"
        user.unpaid_marked_manuals.each do |manual|
          manual.eway_payment = @payment
          manual.save
        end
      end
      
      user.last_payed_at = Time.now
      
      unless user.save
        # let us know
      end
    end
    
  end
  
end