CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                                      # required
    :aws_access_key_id      => 'AKIAISQMWFVO22QFIGSQ',                     # required
    :aws_secret_access_key  => '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'              # required
    #:region                 => 'us-west-1'                                 # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'solarmanuals'                                 # required
  # config.asset_host     = 'http://solarmanuals.s3.amazonaws.com/'        # optional, defaults to nil
  config.fog_public     = true                                            # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}           # optional, defaults to {}
end