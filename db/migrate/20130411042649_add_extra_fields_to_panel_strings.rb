class AddExtraFieldsToPanelStrings < ActiveRecord::Migration
  def change
    add_column :panel_strings, :polarity, :string
    add_column :panel_strings, :short_circuit, :string
    add_column :panel_strings, :tilt, :string
    add_column :panel_strings, :orientation, :string
  end
end
