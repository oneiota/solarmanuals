class State < ActiveRecord::Base
  
  attr_accessible :name, :disabled
  has_many :manuals
  
end
