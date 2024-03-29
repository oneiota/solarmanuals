class CreateManuals < ActiveRecord::Migration
  def change
    create_table :manuals do |t|
      t.string :client_name
      t.string :client_address
      t.string :client_suburb
      t.timestamp :install_date
      t.string :author_name
      t.string :author_company
      t.string :accreditation_number
      t.string :system_address
      t.string :system_watts
      t.string :system_config
      t.string :system_pv_voltage
      t.string :system_pv_current
      t.string :system_yearly_yield
      t.string :panels_brand
      t.string :panels_model
      t.string :panels_number
      t.text :panels_serial_numbers
      t.string :inverter_brand
      t.string :inverter_model
      t.string :inverter_output
      t.string :inverter_number
      t.string :inverter_serial
      t.string :warranty_workmanship
      t.string :warranty_panels_product
      t.string :warranty_panels_output_performance
      t.string :warranty_inverter
      t.text :diagram_panels_text
      t.text :diagram_inverter_text
      t.string :average_daily
      t.string :average_yearly

      t.timestamps
    end
  end
end
