class PanelString < ActiveRecord::Base
  attr_accessible :amps, :manual_id, :number, :volts
  
  belongs_to :manual
  
  def total
    (number || 0) * (manual.panels_watts || 0)
  end
  
  def total_volts
    (number || 0) * (volts.to_f || 0)
  end
  
end
