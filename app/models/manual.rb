class Manual < ActiveRecord::Base
  attr_accessible :accreditation_number, :author_company, :author_name, :average_daily, :average_yearly, :client_address, :client_name, :client_suburb, :diagram_inverter_text, :diagram_panels_text, :install_date, :inverter_brand, :inverter_model, :inverter_number, :inverter_output, :inverter_serial, :panels_brand, :panels_model, :panels_number, :panels_serial_numbers, :system_address, :system_config, :system_pv_current, :system_pv_voltage, :system_watts, :system_yearly_yield, :warranty_inverter, :warranty_panels_output_performance, :warranty_panels_product, :warranty_workmanship
  validates_presence_of :accreditation_number, :author_company, :author_name, :average_daily, :average_yearly, :client_address, :client_name, :client_suburb, :diagram_inverter_text, :diagram_panels_text, :install_date, :inverter_brand, :inverter_model, :inverter_number, :inverter_output, :inverter_serial, :panels_brand, :panels_model, :panels_number, :panels_serial_numbers, :system_address, :system_config, :system_pv_current, :system_pv_voltage, :system_watts, :system_yearly_yield, :warranty_inverter, :warranty_panels_output_performance, :warranty_panels_product, :warranty_workmanship
  
  def panels_serials
    panels_serial_numbers.split(',').map{ |number| number.strip }
  end
  
end
