IMAGE_OPTS = { 
  :styles => { 
    :thumb => "140x140#" 
  }, 
  :path => "/images/:style/:id/:basename.:extension",
  :url => ':s3_path_url',
  :storage => :s3, 
  :s3_credentials => "#{Rails.root}/config/s3.yml"
}

LOGO_OPTS = { 
  :styles => { 
    :thumb => "140x140#" 
  }, 
  :path => "/logos/:style/:id/:basename.:extension",
  :url => ':s3_path_url',
  :storage => :s3, 
  :s3_credentials => "#{Rails.root}/config/s3.yml"
}