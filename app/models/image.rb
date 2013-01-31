class Image < ActiveRecord::Base
  has_attached_file :file, PAPERCLIP_OPTS
  attr_accessible :file, :manual_id
  
  belongs_to :manual
end
