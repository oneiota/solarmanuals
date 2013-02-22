class PanelString < ActiveRecord::Base
  attr_accessible :amps, :manual_id, :number, :volts
  
  belongs_to :manual
end
