class Eway
  
  def self.client
    @eway_client ||= BigCharger.new(
      '11292907', 
      'info@solarmanuals.com.au', 
      'Avq22888'
    )
  end
  
end