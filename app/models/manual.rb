class Manual < ActiveRecord::Base
  attr_accessible :user_id, :eway_payment_id, :feature_image_id, :pdf_ids,
    :client_address, :client_name, :client_suburb, :client_postcode, :client_state_id, :install_date, :inverter_brand, :inverter_model, :inverter_output, :inverter_serial, :panels_brand, :panels_model, :panels_number, :panels_serial_numbers, :system_config, :system_pv_current, :system_pv_voltage, :system_watts, :warranty_inverter, :warranty_panels_output_performance, :warranty_panels_product, :warranty_workmanship, :sunlight_city, :filled, :trashed, :files_array,
    :contractor_licence, :contractor_licence_name, :contractor_phone, :contractor_name, :inspection_date
  
  validates_presence_of :client_address, :client_name, :client_suburb, :client_state_id, :install_date, :client_postcode
  
  validates_numericality_of :system_pv_current, :system_pv_voltage, :system_watts, :inverter_output, :if => :validate_pdf_fields?, :allow_blank => true
  
  belongs_to :user
  
  belongs_to :eway_payment
  
  has_many :images
  accepts_nested_attributes_for :images
  
  belongs_to :client_state, :class_name => "State"
  
  has_and_belongs_to_many :pdfs
  
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
    attributes.each_pair do |k, v|
      unless ['trashed', 'panels_serial_numbers', 'inverter_serial', 'marked', 'eway_payment_id'].include? k
        if v.nil? || v.blank?
          puts k
          return false
        end
      end
    end
    true
  end
  
  def self.all_completed
    Manual.all.keep_if(&:completed?)
  end
  
  def self.system_details_prefill
    manuals = unique_values("system_watts", "system_pv_current", "system_pv_voltage")
    
    manuals.collect do |m|
      ["#{m['system_watts']}W, #{m['system_pv_current']}Amps, #{m['system_pv_voltage']}V", m['id']]
    end
  end
  
  def self.panel_details_prefill
    manuals = unique_values("panels_brand", "panels_model", "panels_number")
    
    manuals.collect do |m|
      ["#{m['panels_number']} x #{m['panels_brand']} #{m['panels_model']}", m['id']]
    end
  end
  
  def self.inverter_details_prefill
    manuals = unique_values("inverter_brand", "inverter_model", "inverter_output")
    
    manuals.collect do |m|
      ["#{m['inverter_output']} #{m['inverter_brand']} #{m['inverter_model']}", m['id']]
    end
  end
  
  def self.warranty_details_prefill
    manuals = unique_values("warranty_inverter", "warranty_panels_output_performance", "warranty_panels_product", "warranty_workmanship")
    
    manuals.collect do |m|
      ["#{m['warranty_inverter']}, #{m['warranty_panels_output_performance']}, #{m['warranty_panels_product']}, #{m['warranty_workmanship']}", m['id']]
    end
  end
  
  def validate_pdf_fields?
    paid? && !trashed && filled
  end
  
  def paid?
    !!eway_payment
  end
  
  def unlocked?
    paid? || user.subscribed?
  end
  
  def files_array=(array)
    array.each do |file|
      images.build(:file => file)
    end
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
  
  
end
