class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :current_password, :remember_me, :first_name, :last_name, :company, :accreditation, :abn, :company_address, :company_suburb, :company_postcode, :contact_email, :company_phone, :company_fax
  
  attr_accessor :current_password
  
  validates_presence_of :first_name, :last_name
  
  has_many :manuals
  has_one :payment, :as => :payable
  
  def active_manuals
    manuals.where(:trashed => false).order('created_at DESC')
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def subscribed?
    payment && payment.completed && !payment.canceled
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
  
end
