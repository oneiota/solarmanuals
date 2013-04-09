class AddAttachmentFileToSignatures < ActiveRecord::Migration
  def self.up
    change_table :signatures do |t|
      t.has_attached_file :file
    end
  end

  def self.down
    drop_attached_file :signatures, :file
  end
end
