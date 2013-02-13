class AddSubscribedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribed, :boolean, default: false
    add_column :users, :eway_id, :string
  end
end
