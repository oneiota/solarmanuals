class AddInsiderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :insider, :boolean, default: false
  end
end
