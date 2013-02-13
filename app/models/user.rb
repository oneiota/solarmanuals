class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :current_password, :remember_me, :first_name, :last_name, :company, :accreditation, :abn, :company_address, :company_suburb, :company_postcode, :contact_email, :company_phone, :company_fax, :logo, :pdfs_array, :subscribed, :eway_id, :stored_cc_number
  
  has_attached_file :logo, LOGO_OPTS
  validates_attachment :logo,
    :size => { :in => 0..2.megabytes }
  
  attr_accessor :current_password
  
  validates_presence_of :first_name, :last_name
  
  has_many :manuals
  has_many :eway_payments
  
  has_many :pdfs
  accepts_nested_attributes_for :pdfs
  
  def active_manuals
    manuals.where(:trashed => false).order('created_at DESC')
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def subscribed?
    subscribed
  end
  
  def fields_filled?
    !fields_not_filled?
  end
  
  def fields_not_filled?
    [company, accreditation, abn, company_address, company_suburb, company_postcode, contact_email, company_phone, company_fax].each do |field|
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
  
  
  
  # payments
  
  
  def create_eway_id(opts)
    self.eway_id = Eway.client.create_customer(
      'Title' => 'Mr.',
      'FirstName' => first_name,
      'LastName' => last_name,
      'Country' => 'au',
      'CCNumber' => opts[:cc_number],
      'CCExpiryMonth' => opts[:cc_expiry_month],
      'CCExpiryYear' => opts[:cc_expiry_year],
      'CVN' => opts[:cvn]
    )
    
    if opts[:remember] == '1'
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
