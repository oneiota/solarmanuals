class AddShowCheckQuestionToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :show_check_question, :boolean
  end
end
