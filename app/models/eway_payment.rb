class EwayPayment < ActiveRecord::Base
  attr_accessible :eway_auth_code, :eway_error, :eway_status, :return_amount, :transaction_number, :user_id
  
  belongs_to :user
  
end
