class AddStoredCcNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :stored_cc_number, :string
  end
end
