class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.boolean :disabled, default: true
    end
  end
end
