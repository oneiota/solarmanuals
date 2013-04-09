class Signature < ActiveRecord::Base
  has_attached_file :file, SIGNATURE_OPTS
  attr_accessible :file
end
