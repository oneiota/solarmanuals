class EwayPayment < ActiveRecord::Base
  attr_accessible :eway_auth_code, :eway_error, :eway_status, :return_amount, :transaction_number, :user_id
  
  attr_accessor :cc_number, :cc_expiry_month, :cc_expiry_year, :cvn, :remember
  
  belongs_to :user
  has_many :manuals
  
end
