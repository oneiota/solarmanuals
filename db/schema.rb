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

ActiveRecord::Schema.define(:version => 20130213235915) do

  create_table "eway_payments", :force => true do |t|
    t.integer  "user_id"
    t.string   "eway_error"
    t.boolean  "eway_status"
    t.string   "transaction_number"
    t.integer  "return_amount"
    t.string   "eway_auth_code"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "images", :force => true do |t|
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "manual_id"
    t.boolean  "feature",           :default => false
  end

  create_table "manuals", :force => true do |t|
    t.string   "client_name"
    t.string   "client_address"
    t.string   "client_suburb"
    t.datetime "install_date"
    t.string   "system_watts"
    t.string   "system_config"
    t.string   "system_pv_voltage"
    t.string   "system_pv_current"
    t.string   "panels_brand"
    t.string   "panels_model"
    t.string   "panels_number"
    t.text     "panels_serial_numbers"
    t.string   "inverter_brand"
    t.string   "inverter_model"
    t.string   "inverter_output"
    t.string   "inverter_serial"
    t.string   "warranty_workmanship"
    t.string   "warranty_panels_product"
    t.string   "warranty_panels_output_performance"
    t.string   "warranty_inverter"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "sunlight_city"
    t.integer  "user_id"
    t.boolean  "filled",                             :default => false
    t.boolean  "trashed",                            :default => false
    t.integer  "client_state_id"
    t.integer  "contractor_licence"
    t.string   "contractor_licence_name"
    t.string   "contractor_phone"
    t.string   "contractor_name"
    t.datetime "inspection_date"
    t.string   "client_postcode"
    t.integer  "eway_payment_id"
    t.boolean  "marked",                             :default => false
  end

  create_table "manuals_pdfs", :force => true do |t|
    t.integer "pdf_id"
    t.integer "manual_id"
  end

  create_table "pdfs", :force => true do |t|
    t.integer  "user_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "states", :force => true do |t|
    t.string  "name"
    t.boolean "disabled", :default => true
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "accreditation"
    t.string   "abn"
    t.string   "company_address"
    t.string   "company_suburb"
    t.string   "company_postcode"
    t.string   "contact_email"
    t.string   "company_phone"
    t.string   "company_fax"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "insider",                :default => false
    t.boolean  "subscribed",             :default => false
    t.string   "eway_id"
    t.string   "stored_cc_number"
    t.datetime "last_payed_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
