# encoding: UTF-8
require 'open-uri'
require 'fastimage'

class Cover
  def initialize(doc, manual)
    @doc = doc
    @manual = manual
  end
  
  def draw
    
    if @manual.user.logo?
      logo_uri = @manual.user.logo.url(:original)
      logo = open(logo_uri)
      @doc.image logo, :scale => dpi_ratio, :position => :center
    else
      @doc.text "#{@manual.user.company}", :align => :center, :size => 20
    end
    
    @doc.move_down 16*3
    
    @doc.text "Grid Connect PV User Manual", :align => :center, :size => 24, :style => :bold
    
    @doc.move_down 16*2
    
    feature_image
    
    @doc.move_down 16*5
    
    @doc.text "Prepared for #{@manual.client_name} \n#{@manual.client_address} \n#{@manual.client_suburb}, #{@manual.client_state.name} #{@manual.client_postcode}", :align => :center

    @doc.text_box "#{@manual.user.company}\n#{address_line}#{phone_line}System installed by #{@manual.user.full_name} / Accreditation No. #{@manual.user.accreditation}", :at => [0, 16*7], :width => @doc.bounds.width, :style => :bold, :align => :center
    
    @doc.text_box "This document has been prepared as a reference and maintenance manual for the owner of the above PV power system.", :at => [50, 16*2], :width => @doc.bounds.width - 100, :align => :center
  end
  
  def address_line
    "#{@manual.user.company_address} #{@manual.user.company_suburb}\n" if @manual.user.company_address.present?
  end
  
  def phone_line
    str = ""
    str += "Phone #{@manual.user.company_phone}" if @manual.user.company_phone.present?
    str += "    Fax #{@manual.user.company_fax}" if @manual.user.company_fax.present?
    str += "\n"
    str
  end
  
  def feature_image
    if @manual.feature_image && @manual.feature_image.file?
      uri = @manual.feature_image.file.url(:original)
      cover_image = open(uri)
      @doc.image cover_image, :position => :center, :scale => dpi_ratio
    end
  end

  def dpi_ratio
    (72.0/300)
  end
end