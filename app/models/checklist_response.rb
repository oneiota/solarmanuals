class ChecklistResponse < ActiveRecord::Base
  attr_accessible :response
  belongs_to :manual
  belongs_to :checklist_item
end
