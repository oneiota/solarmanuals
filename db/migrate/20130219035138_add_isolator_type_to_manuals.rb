class AddIsolatorTypeToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :isolator_type, :string, :default => "1000V DC"
  end
end
