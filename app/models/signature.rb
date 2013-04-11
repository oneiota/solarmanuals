class Signature < ActiveRecord::Base
  has_attached_file :file, SIGNATURE_OPTS
  attr_accessible :file, :signature_data, :name, :licence
  
  attr_reader :signature_data
  
  after_create :notify_user
  
  def create_file(data)
    data = data.to_s.split(',').pop
    image = StringIO.new(Base64.decode64(data))
    image.class.class_eval { attr_accessor :original_filename, :content_type }
    image.original_filename = 'signature.png'
    image.content_type = 'image/png'
    image
  end
  
  def signature_data=(data)
    self.file = create_file(data)
  end
  
  
  def notify_user
    
  end
  
  def manual
    Manual.where('installer_signature_id = ? OR contractor_signature_id = ?', self.id).first
  end
  
end
