class AddNaToChecklistResponse < ActiveRecord::Migration
  def change
    add_column :checklist_responses, :na, :boolean
  end
end
