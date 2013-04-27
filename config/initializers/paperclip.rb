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
    :original => ["", :jpg],
    :thumb => ["300x", :jpg]
  }, 
  :path => "/logos/:style/:id/:basename.:extension",
  :url => ':s3_path_url',
  :storage => :s3, 
  :s3_credentials => "#{Rails.root}/config/s3.yml"
}

SIGNATURE_OPTS = { 
  :path => "/signatures/:style/:id/:basename.:extension",
  :url => ':s3_path_url',
  :storage => :s3, 
  :s3_credentials => "#{Rails.root}/config/s3.yml"
}


PDF_OPTS = {
  :styles => { :processed => ["", :pdf] },
  :path => "/pdfs/:style/:id/:basename.:extension",
  :url => ':s3_path_url',
  :storage => :s3, 
  :s3_credentials => "#{Rails.root}/config/s3.yml",
  :processors => [:ghostscript]
}

if Rails.env.development?
  IMAGE_OPTS[:path].insert(0, "/dev")
  LOGO_OPTS[:path].insert(0, "/dev")
  SIGNATURE_OPTS[:path].insert(0, "/dev")
  PDF_OPTS[:path].insert(0, "/dev")
end