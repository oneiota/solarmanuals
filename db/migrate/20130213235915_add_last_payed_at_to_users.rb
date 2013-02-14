class AddLastPayedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_payed_at, :timestamp
  end
end
