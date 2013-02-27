class AddStepToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :current_step, :string
  end
end
