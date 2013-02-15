class EwayPayment < ActiveRecord::Base
  
  attr_accessible :eway_auth_code, :eway_error, :eway_status, :return_amount, :transaction_number, :user_id
  
  attr_accessor :cc_number, :cc_expiry_month, :cc_expiry_year, :cvn, :remember
  
  validates_presence_of :return_amount, :transaction_number, :user_id
  
  belongs_to :user
  has_many :manuals
  
  def process_subscription!
    
    charge_amount = user.current_charge
    
    return if charge_amount == 0
    
    response = Eway.client.process_payment(
      user.eway_id,
      charge_amount,
      'Solar Manuals Subscription'
    )
    
    self.eway_error = response['ewayTrxnError']
    self.eway_status = response['ewayTrxnStatus']
    self.transaction_number = response['ewayTrxnNumber']
    self.return_amount = response['ewayReturnAmount']
    self.eway_auth_code = response['ewayAuthCode']
    
    if self.save!
      puts "Created payment for #{user.first_name} #{user.last_name} at #{charge_amount}"
      
      user.last_payed_at = Time.now
      
      user.save
      
      user.unpaid_marked_manuals.each do |manual|
        manual.eway_payment = self
        manual.save
      end
      
      return true
    else
      # let us know
    end
    
  end
  
  
  def process_unsubscribe_payment!
    
    
    
  end
  
end
