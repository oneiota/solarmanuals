class ChecklistItem < ActiveRecord::Base

  attr_accessible :checklist_group_id, :label, :helper, :field_type
  has_many :checklist_responses, :dependent => :destroy
  has_many :manuals, :through => :checklist_responses
  belongs_to :checklist_group
  
end
