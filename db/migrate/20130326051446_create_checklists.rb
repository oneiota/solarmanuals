class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.text :question
    end
  end
end
