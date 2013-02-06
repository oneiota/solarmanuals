class Image < ActiveRecord::Base
  has_attached_file :file, IMAGE_OPTS
  attr_accessible :file, :manual_id, :feature
  
  belongs_to :manual
  
  def feature_image_class(feature_id)
    feature ? 'feature' : ''
  end
  
  def unfeature
    self.feature = false
    save!
  end
  
end
