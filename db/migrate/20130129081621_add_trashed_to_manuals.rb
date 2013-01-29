class AddTrashedToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :trashed, :boolean, default: false
  end
end
