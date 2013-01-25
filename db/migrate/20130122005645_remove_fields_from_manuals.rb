class RemoveFieldsFromManuals < ActiveRecord::Migration
  def change
    remove_column :manuals, :system_yearly_yield
    remove_column :manuals, :diagram_panels_text
    remove_column :manuals, :diagram_inverter_text
    remove_column :manuals, :average_daily
    remove_column :manuals, :average_yearly
  end
end
