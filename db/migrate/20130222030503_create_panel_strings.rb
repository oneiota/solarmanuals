class CreatePanelStrings < ActiveRecord::Migration
  def change
    create_table :panel_strings do |t|
      t.integer :number
      t.string :volts
      t.string :amps
      t.integer :manual_id

      t.timestamps
    end
  end
end
