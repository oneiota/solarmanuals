class EwayPayment < ActiveRecord::Base

  attr_accessible :eway_auth_code, :eway_error, :eway_status, :return_amount, :transaction_number, :user_id

  attr_accessor :cc_number, :cc_expiry_month, :cc_expiry_year, :cvn, :remember

  validates_presence_of :return_amount, :transaction_number, :user_id

  validate :transaction_approved

  belongs_to :user
  has_many :manuals


  def self.process_single_payment!(user)
    @payment = EwayPayment.new
    @payment.user = user

    # create new eway id if we don't have one yet, or they've entered new details
    if !user.eway_id || user.cc_number
      user.eway_id = user.create_eway_id
    end

    @payment.process_payment!(CASUAL_FEE)

    if @payment.save
      # email receipt
      UserMailer.receipt(@payment).deliver
    end

    return @payment
  end

  def process_payment!(amount)
    response = Eway.client.process_payment(
      user.eway_id,
      amount,
      'Solar Manuals Subscription'
    )

    set_payment_details(response)
  end

  def process_subscription!
    charge_amount = user.current_charge
    return if charge_amount == 0

    self.process_payment!(charge_amount)

    self.subscription = true

    if self.save
      puts "Created payment for #{user.full_name} at #{charge_amount}"

      user.flagged = false
      user.last_payed_at = Time.now
      user.save

      user.unpaid_marked_manuals.each do |manual|
        manual.eway_payment = self
        manual.save
      end

      # email receipt
      UserMailer.receipt(self).deliver

      return true

    else

      puts "Payment failed for #{user.full_name}, #{errors[:base].first}"
      UserMailer.admin_payment_alert(self).deliver
      UserMailer.payment_failed_alert(self).deliver

      user.flag!
      return false
    end
  end

  def process_unsubscribe_payment!

  end

  private

  def set_payment_details(response)
    self.eway_error = response['ewayTrxnError']
    self.eway_status = response['ewayTrxnStatus'] == "True"
    self.transaction_number = response['ewayTrxnNumber']
    self.return_amount = response['ewayReturnAmount']
    self.eway_auth_code = response['ewayAuthCode']
  end

  def transaction_approved
    error = self.eway_error.split(",")
    unless error.first == "00"
      errors[:base] << error.last
    end
  end

end
