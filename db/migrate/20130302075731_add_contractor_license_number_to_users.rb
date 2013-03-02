class AddContractorLicenseNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contractor_license_number, :string
  end
end
