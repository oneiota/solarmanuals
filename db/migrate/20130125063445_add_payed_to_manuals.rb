class AddPayedToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :payed, :boolean, :default => false
  end
end
