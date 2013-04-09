class Manual < ActiveRecord::Base
  
  attr_protected :marked
  
  validates_presence_of :client_address, :client_name, :client_suburb, :client_state_id, :install_date, :client_postcode, :if => :not_duplicate?
  
  validates_numericality_of :system_pv_current, :system_pv_voltage, :system_watts, :inverter_output, :inverter_number, :if => :validate_pdf_fields?, :allow_blank => true
  
  belongs_to :user
  
  belongs_to :eway_payment
  
  has_many :images
  accepts_nested_attributes_for :images
  
  belongs_to :client_state, :class_name => "State"
  
  has_and_belongs_to_many :pdfs
  
  has_many :panel_strings
  accepts_nested_attributes_for :panel_strings, :allow_destroy => true
  
  accepts_nested_attributes_for :user
  
  has_and_belongs_to_many :checklists
  
  has_many :checklist_responses
  has_many :checklist_items, through => :checklist_responses
  
  attr_accessor :payment, :prefill_id, :duplicate
  
  after_save :build_strings
  
  def build_strings
    panel_strings.build unless panel_strings.count > 0
  end
  
  # steps
  
  def steps
    %w{customer panels inverter warranties performance wiring} + (user.subscribed? || paid? || user.insider || user.manuals.count == 0 ? [] : %w{payment})
  end
  
  def step_index(step)
    steps.index(step)
  end
  
  def past_step?(step)
    current_step_index < step_index(step)
  end
  
  def before_step?(step)
    current_step_index > step_index(step)    
  end
  
  def before_or_equal_step?(step)
    current_step_index >= step_index(step)    
  end
  
  def current_step_index
    step_index(current_step) || 99
  end
  
  def current_step?(step)
    current_step == step
  end
  
  def last_step?
    current_step == steps.last
  end
  
  def next_step
    steps[current_step_index + 1]
  end
  
  def step_back
    self.current_step = steps[current_step_index - 1]
  end

  def preview_detail(step)
    {
      "customer" => client_name,
      "panels" => "#{panels_watts}W #{panels_brand} #{panels_model}",
      "inverter" => "#{inverter_brand} #{inverter_series} #{inverter_model}",
      "warranties" => [warranty_inverter, warranty_panels_output_performance, warranty_panels_product, warranty_workmanship].join(", "),
      "performance" => (include_performance ? "#{sunlight_city.capitalize}, #{(performance_multiplier * 100).to_i}%" : 'No'),
      "wiring" => (include_wiring ? 'Yes' : 'No'),
      "certificate" => (include_certificate ? 'Yes' : 'No')
    }[step]
  end
  
  
  
  # dynamic fields
  
  # number of panels in each string
  def total_panels
    panel_strings.map{|string| (string.number || 0) }.inject(:+)
  end
  
  def total_array_size
    (total_panels || 0) * (panels_watts || 0) # whiny nils throw exception
  end
  
  def string_config
    panel_strings.map { |string|
      "<b>1 string of #{string.number} panels, #{string.volts} Volts DC, #{string.amps} Amps</b>"
    }.join("\n")
  end
  
  def display_address
    "#{client_address}"
  end
  
  def feature_image
    Image.where(manual_id: id, feature: true).first
  end
  
  def panels_serials
    panels_serial_numbers.split(',').map{ |number| number.strip }
  end
  
  def panels_table
    buffer = ""
    index = 1
    line_text = ""
    panels_serials.each do |number|
      line_text += "|#{index}. <b>#{number}</b>"
      if index % 3 == 0
        buffer << "#{line_text}|\n"
        line_text = ""
      end
      index += 1
    end
    buffer << "#{line_text}|" unless line_text.blank?
    buffer
  end
  
  
  # 
  
  def self.not_trashed
    where(:trashed => false)
  end
  
  def self.all_completed
    Manual.all.keep_if(&:completed?)
  end
  
  
  def validate_pdf_fields?
    paid? && !trashed && filled
  end
  
  def free_one?
    user.is_first_manual?(self)
  end
  
  def paid?
    (!!eway_payment) || free_one?
  end
  
  def unlocked?
    paid? || user.subscribed? || user.insider
  end
  
  def filled?
    paid? || filled || current_step.nil?
  end
  
  
  def marked?
    marked && user.subscribed?
  end
  
  def files_array=(array)
    array.each do |file|
      images.build(:file => file)
    end
  end
  
  # [ {key: 10%, value: 0.10}, {key: 15%, value: 0.15}, ... , {key: 100%, value: 1.0}]
  def multipliers
    (10..100).step(5).map{|n| ["#{n}%", (n / 100.0)] }
  end
  
  
  
  
  private
  
  
  def self.all_present?(array)
    array.each do |v|
      return false if v.blank?
    end
    true
  end
  
  def not_duplicate?
    !duplicate
  end
  
  
  
end
