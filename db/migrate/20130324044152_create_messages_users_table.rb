class CreateMessagesUsersTable < ActiveRecord::Migration
  def self.up
    create_table :messages_users, :id => false do |t|
        t.references :message
        t.references :user
    end
    add_index :messages_users, [:message_id, :user_id]
    add_index :messages_users, [:user_id, :message_id]
  end

  def self.down
    drop_table :messages_users
  end
end
