class CreateEwayPayments < ActiveRecord::Migration
  def change
    create_table :eway_payments do |t|
      t.integer :user_id
      t.string :eway_error
      t.boolean :eway_status
      t.string :transaction_number
      t.integer :return_amount
      t.string :eway_auth_code

      t.timestamps
    end
  end
end
