class SwapFeatureIdOnManuals < ActiveRecord::Migration
  def up
    remove_column :manuals, :feature_image_id
    add_column :images, :feature, :boolean, :default => false
  end
  
  def down
    add_column :manuals, :feature_image_id, :integer
    remove_column :images, :feature
  end
end
