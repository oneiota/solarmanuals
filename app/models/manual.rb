# :user_id, :eway_payment_id, :feature_image_id, :pdf_ids,
# 
# :client_address, :client_name, :client_suburb, :client_postcode, :client_state_id, :install_date, 
# 
# :inverter_brand, :inverter_model, :inverter_output, :inverter_serial, 
# :panels_brand, :panels_model, :panels_number, :panels_serial_numbers, 
# 
# :system_config, :system_pv_current, :system_pv_voltage, :system_watts, 
# 
# :warranty_inverter, :warranty_panels_output_performance, :warranty_panels_product, :warranty_workmanship, 
# 
# :sunlight_city, 
# 
# :filled, :trashed, :files_array, 
# 
# :include_performance, :include_wiring, :include_certificate, 
# 
# :isolator_type, :inverter_number,
# 
# :contractor_licence, :contractor_licence_name, :contractor_phone, :contractor_name, :inspection_date


class Manual < ActiveRecord::Base
  
  attr_protected :marked
  
  validates_presence_of :client_address, :client_name, :client_suburb, :client_state_id, :install_date, :client_postcode
  
  validates_numericality_of :system_pv_current, :system_pv_voltage, :system_watts, :inverter_output, :inverter_number, :if => :validate_pdf_fields?, :allow_blank => true
  
  belongs_to :user
  
  belongs_to :eway_payment
  
  has_many :images
  accepts_nested_attributes_for :images
  
  belongs_to :client_state, :class_name => "State"
  
  has_and_belongs_to_many :pdfs
  
  has_many :panel_strings
  accepts_nested_attributes_for :panel_strings, :allow_destroy => true
  
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
  
  def completed?
    [client_address, client_name, client_suburb, client_postcode, client_state_id, install_date, inverter_brand, inverter_model, inverter_output, inverter_number, panels_brand, panels_model, panels_number, system_config, system_pv_current, system_pv_voltage, system_watts, warranty_inverter, warranty_panels_output_performance, warranty_panels_product, warranty_workmanship].each do |key|
      if key.nil? || key.blank?
        return false
      end
    end
    true
  end
  
  def self.all_completed
    Manual.all.keep_if(&:completed?)
  end
  
  def self.system_details_prefill
    prefill("system_watts", "system_pv_current", "system_pv_voltage")
  end
  
  def self.panel_details_prefill
    prefill("panels_brand", "panels_model", "panels_number")
  end
  
  def self.inverter_details_prefill
    prefill("inverter_brand", "inverter_model", "inverter_output")
  end
  
  def self.warranty_details_prefill
    prefill("warranty_inverter", "warranty_panels_output_performance", "warranty_panels_product", "warranty_workmanship")
  end
  
  
  def validate_pdf_fields?
    paid? && !trashed && filled
  end
  
  def paid?
    !!eway_payment
  end
  
  def unlocked?
    paid? || user.subscribed? || user.insider
  end
  
  def files_array=(array)
    array.each do |file|
      images.build(:file => file)
    end
  end
  
  PREFILL_FIELDS = {
    'system_details_prefill' => "system_watts, system_pv_current, system_pv_voltage, system_config",
    'panel_details_prefill' => "panels_brand, panels_model, panels_number",
    'inverter_details_prefill' => "inverter_brand, inverter_model, inverter_output, inverter_number",
    'warranty_details_prefill' => "warranty_inverter, warranty_panels_output_performance, warranty_panels_product, warranty_workmanship"
  }
  
  def self.find_with_type(id, type)
    find(id, {:select => PREFILL_FIELDS[type]})
  end
  
  private
  
  
  def self.unique_values(*fields)
    manuals = []
    all(:select => fields.concat(['id']).join(", ")).each do |m|

      # hash exists in array (minus id)
      unless manuals.map{ |m| m.except("id") }.include? m.attributes.except("id")
        manuals << m.attributes
      end
    end
    manuals
  end
  
  def self.prefill(*fields)
    manuals = unique_values(fields)
    manuals.delete_if do |manual|
      !(all_present?(manual.values))
    end
    manuals.collect do |m|
      values = fields.map do |field|
        m[field]
      end
      [values.join(", "), m['id']]
    end
  end
  
  def self.all_present?(array)
    array.each do |v|
      return false if v.blank?
    end
    true
  end

end
