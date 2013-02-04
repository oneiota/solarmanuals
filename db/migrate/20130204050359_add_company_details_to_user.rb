class AddCompanyDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :abn, :string
    add_column :users, :company_address, :string
    add_column :users, :company_suburb, :string
    add_column :users, :company_postcode, :string
    add_column :users, :contact_email, :string
    add_column :users, :company_phone, :string
    add_column :users, :company_fax, :string
  end
end
