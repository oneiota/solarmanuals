class AddDesignerFieldsToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :account_designer, :boolean, :default => true
    add_column :manuals, :designer_name, :string
    add_column :manuals, :designer_accreditation, :string
  end
end
