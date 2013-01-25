class Manual < ActiveRecord::Base
  attr_accessible :user_id, :payment_id,
    :client_address, :client_name, :client_suburb, :install_date, :inverter_brand, :inverter_model, :inverter_number, :inverter_output, :inverter_serial, :panels_brand, :panels_model, :panels_number, :panels_serial_numbers, :system_address, :system_config, :system_pv_current, :system_pv_voltage, :system_watts, :warranty_inverter, :warranty_panels_output_performance, :warranty_panels_product, :warranty_workmanship, :sunlight_city
  
  validates_presence_of :client_address, :client_name, :client_suburb, :install_date, :inverter_brand, :inverter_model, :inverter_number, :inverter_output, :inverter_serial, :panels_brand, :panels_model, :panels_number, :panels_serial_numbers, :system_address, :system_config, :system_pv_current, :system_pv_voltage, :system_watts, :warranty_inverter, :warranty_panels_output_performance, :warranty_panels_product, :warranty_workmanship
  
  belongs_to :user
  belongs_to :payment
  
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
end
