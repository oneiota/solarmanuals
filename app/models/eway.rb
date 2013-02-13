class Eway
  
  def self.client
    @eway_client ||= BigCharger.new(
      '87654321', 
      'test@eway.com.au', 
      'test123',
      true # test_mode
    )
  end
  
end