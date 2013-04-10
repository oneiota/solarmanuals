class ManualSerializer < ActiveModel::Serializer
  attributes :id
  has_one :installer_signature
  has_one :contractor_signature
end