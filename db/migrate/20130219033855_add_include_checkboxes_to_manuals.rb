class AddIncludeCheckboxesToManuals < ActiveRecord::Migration
  def up
    add_column :manuals, :include_performance, :boolean, default: false
    add_column :manuals, :include_wiring, :boolean, default: false
    add_column :manuals, :include_certificate, :boolean, default: false
    
    Manual.all.each do |m|
      m.update_attributes(:include_performance => true, :include_wiring => true, :include_certificate => true)
    end
  end
  
  def down
    remove_column :manuals, :include_performance
    remove_column :manuals, :include_wiring
    remove_column :manuals, :include_certificate
  end
end
