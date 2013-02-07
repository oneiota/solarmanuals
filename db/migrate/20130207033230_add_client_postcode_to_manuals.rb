class AddClientPostcodeToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :client_postcode, :string
  end
end
