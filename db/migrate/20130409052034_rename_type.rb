class RenameType < ActiveRecord::Migration
  def change
    rename_column :checklist_items, :type, :field_type
  end
end
