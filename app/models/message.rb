class Message < ActiveRecord::Base
  attr_accessible :content, :flashtype
  
  has_and_belongs_to_many :users
  
end
