class AddInverterNumberToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :inverter_number, :integer, default: 1
  end
end
