class AddInverterSeriesToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :inverter_series, :string
  end
end
