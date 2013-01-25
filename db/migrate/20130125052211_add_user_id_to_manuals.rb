class AddUserIdToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :user_id, :integer
  end
end
