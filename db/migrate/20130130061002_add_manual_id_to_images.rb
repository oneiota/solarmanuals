class AddManualIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :manual_id, :integer
  end
end
