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

ActiveRecord::Schema.define(:version => 20130411053027) do

  create_table "checklist_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "checklist_items", :force => true do |t|
    t.integer  "checklist_group_id"
    t.text     "label"
    t.string   "helper"
    t.string   "field_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "checklist_responses", :force => true do |t|
    t.integer  "manual_id"
    t.integer  "checklist_item_id"
    t.string   "response"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "checklists", :force => true do |t|
    t.text "question"
  end

  create_table "checklists_manuals", :id => false, :force => true do |t|
    t.integer "checklist_id"
    t.integer "manual_id"
  end

  add_index "checklists_manuals", ["checklist_id", "manual_id"], :name => "index_checklists_manuals_on_checklist_id_and_manual_id"
  add_index "checklists_manuals", ["manual_id", "checklist_id"], :name => "index_checklists_manuals_on_manual_id_and_checklist_id"

  create_table "eway_payments", :force => true do |t|
    t.integer  "user_id"
    t.string   "eway_error"
    t.boolean  "eway_status"
    t.string   "transaction_number"
    t.integer  "return_amount"
    t.string   "eway_auth_code"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "subscription",       :default => false
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
    t.datetime "created_at",                                                                               :null => false
    t.datetime "updated_at",                                                                               :null => false
    t.string   "sunlight_city"
    t.integer  "user_id"
    t.boolean  "filled",                                                           :default => false
    t.boolean  "trashed",                                                          :default => false
    t.integer  "client_state_id"
    t.integer  "contractor_licence"
    t.string   "contractor_licence_name"
    t.string   "contractor_phone"
    t.string   "contractor_name"
    t.datetime "inspection_date"
    t.string   "client_postcode"
    t.integer  "eway_payment_id"
    t.boolean  "marked",                                                           :default => false
    t.boolean  "include_performance",                                              :default => false
    t.boolean  "include_wiring",                                                   :default => false
    t.boolean  "include_certificate",                                              :default => false
    t.string   "isolator_type",                                                    :default => "1000V DC"
    t.integer  "inverter_number",                                                  :default => 1
    t.integer  "panels_watts"
    t.string   "inverter_series"
    t.string   "current_step"
    t.decimal  "performance_multiplier",             :precision => 8, :scale => 2, :default => 0.75
    t.integer  "installer_signature_id"
    t.integer  "contractor_signature_id"
    t.string   "installer_signature_email"
    t.string   "contractor_signature_email"
    t.boolean  "account_installer",                                                :default => true
    t.boolean  "account_contractor",                                               :default => true
    t.boolean  "account_designer",                                                 :default => true
    t.string   "designer_name"
    t.string   "designer_accreditation"
  end

  create_table "manuals_pdfs", :force => true do |t|
    t.integer "pdf_id"
    t.integer "manual_id"
  end

  create_table "messages", :force => true do |t|
    t.text     "content"
    t.string   "flashtype",  :default => "notice"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "messages_users", :id => false, :force => true do |t|
    t.integer "message_id"
    t.integer "user_id"
  end

  add_index "messages_users", ["message_id", "user_id"], :name => "index_messages_users_on_message_id_and_user_id"
  add_index "messages_users", ["user_id", "message_id"], :name => "index_messages_users_on_user_id_and_message_id"

  create_table "panel_strings", :force => true do |t|
    t.integer  "number"
    t.string   "volts"
    t.string   "amps"
    t.integer  "manual_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pdfs", :force => true do |t|
    t.integer  "user_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "signatures", :force => true do |t|
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "name"
    t.string   "licence"
  end

  create_table "states", :force => true do |t|
    t.string  "name"
    t.boolean "disabled", :default => true
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "email",                     :default => "",    :null => false
    t.string   "encrypted_password",        :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             :default => 0
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
    t.boolean  "insider",                   :default => false
    t.boolean  "subscribed",                :default => false
    t.string   "eway_id"
    t.string   "stored_cc_number"
    t.datetime "last_payed_at"
    t.boolean  "flagged",                   :default => false
    t.string   "contractor_license_number"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
