class AddCertificateDetailsToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :contractor_licence, :integer
    add_column :manuals, :contractor_licence_name, :string
    add_column :manuals, :contractor_phone, :string
    add_column :manuals, :contractor_name, :string
    add_column :manuals, :inspection_date, :datetime
  end
end
