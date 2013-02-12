class Pdf < ActiveRecord::Base
  has_attached_file :file, PDF_OPTS
  attr_accessible :file, :user_id
  
  belongs_to :user
  has_and_belongs_to_many :manuals
end
