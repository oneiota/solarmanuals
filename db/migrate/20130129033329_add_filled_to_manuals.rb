class AddFilledToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :filled, :boolean, default: false
  end
end
