class Image < ActiveRecord::Base
  belongs_to :manual
  has_attached_file :file, PAPERCLIP_OPTS
  attr_accessible :file, :manual_id
end
