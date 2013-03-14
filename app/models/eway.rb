class Eway
  
  def self.client
    @eway_client ||= BigCharger.new(*EWAY)
  end
  
end