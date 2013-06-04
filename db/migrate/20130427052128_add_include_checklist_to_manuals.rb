class AddIncludeChecklistToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :include_checklist, :boolean, :default => false
  end
end
