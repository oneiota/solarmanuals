class ManualSerializer < ActiveModel::Serializer
  attributes :prefill_id, :panels_watts, :panels_brand, :panels_model, :panels_number, 
  
  :inverter_number, :inverter_series, :inverter_brand, :inverter_model, :inverter_output, 
  
  :warranty_workmanship, :warranty_panels_product, :warranty_panels_output_performance, :warranty_inverter,
  
  :include_performance, :performance_multiplier, :sunlight_city,
  
  :include_wiring, :isolator_type
  
  has_many :panel_strings, :key => :panel_strings_attributes
  
  def prefill_id
    object.id
  end
end
