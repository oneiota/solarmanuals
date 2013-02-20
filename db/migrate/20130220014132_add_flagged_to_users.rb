class AddFlaggedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :flagged, :boolean, default: false
  end
end
