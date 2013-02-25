class PanelString < ActiveRecord::Base
  attr_accessible :amps, :manual_id, :number, :volts
  
  belongs_to :manual
  
  def total
    number * manual.panels_watts
  end
  
end
