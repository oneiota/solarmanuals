class CreateManualsPdfs < ActiveRecord::Migration
  def change
    create_table :manuals_pdfs do |t|
      t.integer :pdf_id
      t.integer :manual_id
    end
  end
end
