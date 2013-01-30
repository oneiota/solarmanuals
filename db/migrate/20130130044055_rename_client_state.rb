class RenameClientState < ActiveRecord::Migration
  def change
    rename_column :manuals, :client_state, :client_state_id
  end
end
