class AddMarkedToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :marked, :boolean, default: false
  end
end
