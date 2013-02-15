namespace :solar do
  
  task :run_payments => :environment do
    
    User.billable.each do |user|      
      @payment = EwayPayment.new
      @payment.user = user
      @payment.process_subscription!
    end
    
  end
  
end