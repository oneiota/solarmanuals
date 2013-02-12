class AddAttachmentFileToPdfs < ActiveRecord::Migration
  def self.up
    change_table :pdfs do |t|
      t.has_attached_file :file
    end
  end

  def self.down
    drop_attached_file :pdfs, :file
  end
end
