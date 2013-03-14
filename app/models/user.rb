class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  
  attr_protected :insider
  
  has_attached_file :logo, LOGO_OPTS
  validates_attachment :logo,
    :size => { :in => 0..2.megabytes }
  
  attr_accessor :current_password, :cc_number, :cc_expiry_month, :cc_expiry_year, :cvn, :remember, :validate_card
  
  validates :cc_number, :length => { :is => 16 }, :if => :should_validate_card?
  validates :cc_expiry_month, :length => { :is => 2 }, :if => :should_validate_card?
  validates :cc_expiry_year, :length => { :is => 2 }, :if => :should_validate_card?
  validates :cvn, :length => { :in => 3..4 }, :if => :should_validate_card?
  
  def should_validate_card?
    validate_card
  end
  
  validates_presence_of :first_name, :last_name
  
  has_many :manuals
  has_many :eway_payments
  
  has_many :pdfs
  accepts_nested_attributes_for :pdfs
  
  def active_manuals
    manuals.where(:trashed => false).order('install_date DESC').includes(:eway_payment)
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def full_address
    "#{company_address} #{company_suburb} #{company_postcode}"
  end
  
  def subscribed?
    subscribed
  end
  
  def fields_filled?
    !fields_not_filled?
  end
  
  def fields_not_filled?
    [company, accreditation, abn, company_address, company_suburb, company_postcode, contact_email, company_phone].each do |field|
      return true if field.blank?
    end
    false
  end
  
  def update_with_password(params={}) 
    if params[:password].blank? 
      params.delete(:password)      
      params.delete(:current_password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
    end 
    update_attributes(params) 
  end
  
  def is_new?
    manuals.count == 0
  end
  
  def pdfs_array=(array)
    array.each do |file|
      pdfs.build(:file => file)
    end
  end
  
  def unpaid_marked_manuals
    manuals.where(:eway_payment_id => nil, :marked => true)
  end
  
  def billable_manuals(number)
    ms = number - FREE_MANUALS
    ms < 0 ? 0 : ms
  end
  
  def manuals_charge(number)
    billable_manuals(number) * SUBSCRIPTION_MANUAL_FEE
  end
  
  def current_charge
    charge = manuals_charge(billable_manuals(unpaid_marked_manuals.count))
    charge + SUBSCRIPTION_FEE
  end
  
  # payments
  
  def self.billable
    where(:subscribed => true).where('last_payed_at <= ?', SUBSCRIPTION_INTERVAL.ago).where('eway_id IS NOT NULL').where(:insider => false)
  end
  
  def is_billable?
    User.billable.include?(self)
  end
  
  def create_eway_id
    self.eway_id = Eway.client.create_customer(
      'CustomerRef' => self.id,
      'Title' => 'Mr.',
      'FirstName' => first_name,
      'LastName' => last_name,
      'Company' => '',
      'Country' => 'au',
      'Email' => '',
      'Address' => '',
      'Suburb' => '',
      'State' => '',
      'PostCode' => '',
      'Phone' => '',
      'Mobile' => '',
      'Fax' => '',
      'URL' => '',
      'JobDesc' => '',
      'Comments' => '',
      'CCNumber' => cc_number,
      'CCNameOnCard' => '',
      'CCExpiryMonth' => cc_expiry_month,
      'CCExpiryYear' => cc_expiry_year
    )
    
    if remember == '1'
      self.save
    end
    
    return self.eway_id
  end
  
  def stored_cc_number
    self[:stored_cc_number] || get_cc_number
  end
  
  private
  
  def get_cc_number
    if !eway_id
      return nil
    end
    response = Eway.client.query_customer(eway_id)
    self.stored_cc_number = response['CCNumber']
    self.save
    return self.stored_cc_number
  end
  
  
  
  
end
