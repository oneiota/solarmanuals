class Image < ActiveRecord::Base
  has_attached_file :file, IMAGE_OPTS
  attr_accessible :file, :manual_id
  
  belongs_to :manual
end
