class RemoveInverterNumberFromManuals < ActiveRecord::Migration
  def up
    remove_column :manuals, :inverter_number
  end

  def down
    add_column :manuals, :inverter_number, :string
  end
end
