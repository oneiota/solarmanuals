class AddVocAndIscToStrings < ActiveRecord::Migration
  def change
    add_column :panel_strings, :voc, :string
    add_column :panel_strings, :isc, :string
  end
end
