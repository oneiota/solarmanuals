class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.integer :checklist_group_id
      t.text :label
      t.string :helper
      t.string :type

      t.timestamps
    end
  end
end
