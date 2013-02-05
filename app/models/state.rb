class State < ActiveRecord::Base
  
  attr_accessible :name, :disabled
  has_many :manuals
  
  def display_name
    disabled ? "#{name} - Coming Soon" : name
  end
  
end
