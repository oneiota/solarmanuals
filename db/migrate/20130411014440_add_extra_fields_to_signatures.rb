class AddExtraFieldsToSignatures < ActiveRecord::Migration
  def change
    add_column :signatures, :name, :string
    add_column :signatures, :licence, :string
  end
end
