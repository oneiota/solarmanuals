class AddSignatureCheckboxes < ActiveRecord::Migration
  def change
    add_column :manuals, :account_installer, :boolean, :default => true
    add_column :manuals, :account_contractor, :boolean, :default => true
  end
end
