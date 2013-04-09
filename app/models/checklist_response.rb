class ChecklistResponse < ActiveRecord::Base
  attr_accessible :response, :checklist_item_id
  belongs_to :manual
  belongs_to :checklist_item
end
