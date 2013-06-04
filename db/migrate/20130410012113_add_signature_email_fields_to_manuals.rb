class AddSignatureEmailFieldsToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :installer_signature_email, :string
    add_column :manuals, :contractor_signature_email, :string
  end
end
