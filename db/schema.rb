# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130108023538) do

  create_table "manuals", :force => true do |t|
    t.string   "client_name"
    t.string   "client_address"
    t.string   "client_suburb"
    t.datetime "install_date"
    t.string   "author_name"
    t.string   "author_company"
    t.string   "accreditation_number"
    t.string   "system_address"
    t.string   "system_watts"
    t.string   "system_config"
    t.string   "system_pv_voltage"
    t.string   "system_pv_current"
    t.string   "system_yearly_yield"
    t.string   "panels_brand"
    t.string   "panels_model"
    t.string   "panels_number"
    t.text     "panels_serial_numbers"
    t.string   "inverter_brand"
    t.string   "inverter_model"
    t.string   "inverter_output"
    t.string   "inverter_number"
    t.string   "inverter_serial"
    t.string   "warranty_workmanship"
    t.string   "warranty_panels_product"
    t.string   "warranty_panels_output_performance"
    t.string   "warranty_inverter"
    t.text     "diagram_panels_text"
    t.text     "diagram_inverter_text"
    t.string   "average_daily"
    t.string   "average_yearly"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

end
