class AddPanelsWattsToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :panels_watts, :integer
  end
end
