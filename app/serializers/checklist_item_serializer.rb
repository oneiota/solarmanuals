class ChecklistItemSerializer < ActiveModel::Serializer
  attributes :id, :checklist_group_id, :label, :helper, :type
end
