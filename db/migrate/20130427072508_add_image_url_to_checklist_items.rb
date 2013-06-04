class AddImageUrlToChecklistItems < ActiveRecord::Migration
  def change
    add_column :checklist_items, :image_url, :string
  end
end
