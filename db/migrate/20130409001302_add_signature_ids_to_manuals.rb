class AddSignatureIdsToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :installer_signature_id, :integer
    add_column :manuals, :contractor_signature_id, :integer
  end
end
