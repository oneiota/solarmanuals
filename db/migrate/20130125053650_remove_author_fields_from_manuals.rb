class RemoveAuthorFieldsFromManuals < ActiveRecord::Migration
  def up
    remove_column :manuals, :author_name
    remove_column :manuals, :author_company
    remove_column :manuals, :accreditation_number
  end

  def down
    add_column :manuals, :accreditation_number, :string
    add_column :manuals, :author_company, :string
    add_column :manuals, :author_name, :string
  end
end
