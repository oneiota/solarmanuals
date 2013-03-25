class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.string :flashtype, default: "notice"

      t.timestamps
    end
  end
end
