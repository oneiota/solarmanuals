class ChangeInverterSerialToTextarea < ActiveRecord::Migration
  def change
    change_column :manuals, :inverter_serial, :text
  end
end
