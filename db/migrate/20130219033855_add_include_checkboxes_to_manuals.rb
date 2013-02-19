class AddIncludeCheckboxesToManuals < ActiveRecord::Migration
  def up
    add_column :manuals, :include_performance, :boolean, default: false
    add_column :manuals, :include_wiring, :boolean, default: false
    add_column :manuals, :include_certificate, :boolean, default: false
  end
  
  def down
    remove_column :manuals, :include_performance
    remove_column :manuals, :include_wiring
    remove_column :manuals, :include_certificate
  end
end
