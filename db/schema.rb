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

ActiveRecord::Schema.define(:version => 20130129081621) do

  create_table "manuals", :force => true do |t|
    t.string   "client_name"
    t.string   "client_address"
    t.string   "client_suburb"
    t.datetime "install_date"
    t.string   "system_address"
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
    t.string   "inverter_number"
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
  end

  create_table "payments", :force => true do |t|
    t.integer  "amount",       :default => 1
    t.string   "token"
    t.string   "identifier"
    t.string   "payer_id"
    t.boolean  "recurring",    :default => false
    t.boolean  "digital",      :default => false
    t.boolean  "popup",        :default => false
    t.boolean  "completed",    :default => false
    t.boolean  "canceled",     :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "payable_id"
    t.string   "payable_type"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
