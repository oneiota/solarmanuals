class RemoveContractorFieldsFromSignatures < ActiveRecord::Migration
  def change
    remove_column :manuals, :contractor_signature_id
    remove_column :manuals, :contractor_signature_email
  end
end
