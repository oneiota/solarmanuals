class AddPolymorphicAssociations < ActiveRecord::Migration
  def change
    add_column :payments, :payable_id, :integer
    add_column :payments, :payable_type, :string
    
    remove_column :payments, :user_id
    remove_column :manuals, :payment_id
  end
end
