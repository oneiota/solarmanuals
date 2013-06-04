class ManualSerializer < ActiveModel::Serializer
  attributes :id
  has_one :installer_signature
end