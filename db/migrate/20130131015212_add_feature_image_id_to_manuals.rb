class AddFeatureImageIdToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :feature_image_id, :integer
  end
end
