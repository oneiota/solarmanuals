class AddPaymentIdToManuals < ActiveRecord::Migration
  def up
    add_column :manuals, :payment_id, :integer
    remove_column :manuals, :payed
  end
  
  def down
    remove_column :manuals, :payment_id
    add_column :manuals, :payed, :string
  end
end
