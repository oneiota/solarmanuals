class AddSunlightCityToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :sunlight_city, :string
  end
end
