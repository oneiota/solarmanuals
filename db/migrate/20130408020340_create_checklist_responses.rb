class CreateChecklistResponses < ActiveRecord::Migration
  def change
    create_table :checklist_responses do |t|
      t.integer :manual_id
      t.integer :checklist_item_id
      t.string :response

      t.timestamps
    end
  end
end
