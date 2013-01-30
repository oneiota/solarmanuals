class AddClientStateToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :client_state, :integer
  end
end
