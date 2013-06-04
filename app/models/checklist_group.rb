class ChecklistGroup < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :checklist_items, :dependent => :destroy
end
