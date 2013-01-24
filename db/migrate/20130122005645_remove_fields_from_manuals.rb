class RemoveFieldsFromManuals < ActiveRecord::Migration
  def change
    remove_column :manuals, :system_yearly_yield, :string
    remove_column :manuals, :diagram_panels_text, :string
    remove_column :manuals, :diagram_inverter_text, :string
    remove_column :manuals, :average_daily, :string
    remove_column :manuals, :average_yearly, :string
  end
end
