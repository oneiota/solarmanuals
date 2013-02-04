class RemoveSystemAddressFromManuals < ActiveRecord::Migration
  def up
    remove_column :manuals, :system_address
  end

  def down
    add_column :manuals, :system_address, :string
  end
end
