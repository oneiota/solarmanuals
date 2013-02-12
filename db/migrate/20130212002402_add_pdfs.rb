class AddPdfs < ActiveRecord::Migration
  def change
    create_table :pdfs do |t|
      t.integer :user_id
    end
  end
end
