class ChecklistManualTable < ActiveRecord::Migration
  def up
    create_table :checklists_manuals, :id => false do |t|
      t.references :checklist
      t.references :manual
    end
    add_index :checklists_manuals, [:checklist_id, :manual_id]
    add_index :checklists_manuals, [:manual_id, :checklist_id]
  end

  def down
  drop_table :checklists_manuals
  end
end
