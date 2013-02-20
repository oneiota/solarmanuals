class AddSubscriptionToEwayPayments < ActiveRecord::Migration
  def change
    add_column :eway_payments, :subscription, :boolean, default: false
  end
end
