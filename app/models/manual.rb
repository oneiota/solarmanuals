class Manual < ActiveRecord::Base
  attr_accessible :user_id, :payment_id, :feature_image_id,
    :client_address, :client_name, :client_suburb, :client_state_id, :install_date, :inverter_brand, :inverter_model, :inverter_output, :inverter_serial, :panels_brand, :panels_model, :panels_number, :panels_serial_numbers, :system_config, :system_pv_current, :system_pv_voltage, :system_watts, :warranty_inverter, :warranty_panels_output_performance, :warranty_panels_product, :warranty_workmanship, :sunlight_city, :filled, :trashed, :files_array,
    :contractor_licence, :contractor_licence_name, :contractor_phone, :contractor_name, :inspection_date
  
  validates_presence_of :client_address, :client_name, :client_suburb, :client_state_id, :install_date
  
  validates_presence_of :inverter_brand, :inverter_model, :inverter_output, :inverter_serial, :panels_brand, :panels_model, :panels_number, :panels_serial_numbers, :system_config, :system_pv_current, :system_pv_voltage, :system_watts, :warranty_inverter, :warranty_panels_output_performance, :warranty_panels_product, :warranty_workmanship, :contractor_licence, :contractor_licence_name, :contractor_name, :contractor_phone, :inspection_date, :if => :validate_pdf_fields?
  
  validates_numericality_of :system_pv_current, :system_pv_voltage, :system_watts, :inverter_output, :if => :validate_pdf_fields?
  
  belongs_to :user
  has_one :payment, :as => :payable
  accepts_nested_attributes_for :payment
  
  has_many :images
  accepts_nested_attributes_for :images
  
  belongs_to :client_state, :class_name => "State"
  
  def feature_image
    Image.where(manual_id: id, feature: true).first
  end
  
  def self.not_trashed
    where(:trashed => false)
  end
  
  def panels_serials
    panels_serial_numbers.split(',').map{ |number| number.strip }
  end
  
  def panels_table
    buffer = ""
    index = 1
    line_text = ""
    panels_serials.each do |number|
      line_text += "|#{index}. <b>#{number}</b>"
      if index % 3 == 0
        buffer << "#{line_text}|\n"
        line_text = ""
      end
      index += 1
    end
    buffer << "#{line_text}|" unless line_text.blank?
    buffer
  end
  
  def validate_pdf_fields?
    paid? && !trashed && filled
  end
  
  def paid?
    user.subscribed? || user.insider || (payment && payment.completed && !payment.canceled)
  end
  
  def files_array=(array)
    array.each do |file|
      images.build(:file => file)
    end
  end
  
  
end
