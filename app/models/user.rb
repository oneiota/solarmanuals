class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  
  attr_protected :insider, :eway_id, :subscribed
  
  has_attached_file :logo, LOGO_OPTS
  validates_attachment :logo,
    :size => { :in => 0..2.megabytes }
  
  attr_accessor :current_password, :cc_number, :cc_expiry_month, :cc_expiry_year, :cvn, :remember, :validate_card, :terms
  
  validates :cc_number, :length => { :is => 16 }, :if => :should_validate_card?
  validates :cc_expiry_month, :length => { :is => 2 }, :if => :should_validate_card?
  validates :cc_expiry_year, :length => { :is => 2 }, :if => :should_validate_card?
  validates :cvn, :length => { :in => 3..4 }, :if => :should_validate_card?
  
  def should_validate_card?
    validate_card
  end
  
  validates_presence_of :first_name, :last_name
  
  validate :agree_terms, :on => :create
  
  def agree_terms
    unless terms == '1'
      errors[:terms] = "You must agree."
    end
  end
  
  has_many :manuals
  has_many :eway_payments
  
  has_many :pdfs
  accepts_nested_attributes_for :pdfs
  
  has_and_belongs_to_many :messages
  
  after_create :send_welcome_mail
  
  def unread_message
    if messages.count > 0
      return Message.where('id NOT IN (?)', messages).first
    end
    Message.first
  end
  
  def flash_message
    if unread_message 
      return {unread_message.flashtype.to_sym => [unread_message.id, unread_message.content.html_safe]}
    end
  end
  
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
    manuals.where(:marked => true).reject(&:paid?)
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
  
  def first_manual
    manuals.order('created_at ASC').first
  end
  
  def is_first_manual?(manual)
    if manuals.count > 0
      return manual.id == first_manual.id
    end
    return true
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
  
  def send_welcome_mail
    UserMailer.welcome(self).deliver
  end
  
end
