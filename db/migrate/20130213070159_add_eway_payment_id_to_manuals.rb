class AddEwayPaymentIdToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :eway_payment_id, :integer
  end
end
