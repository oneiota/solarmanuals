# encoding: UTF-8
require 'open-uri'
require 'fastimage'

class Cover
  def initialize(doc, manual)
    @doc = doc
    @manual = manual
  end
  
  def draw
    @doc.text "#{@manual.user.company}", :align => :center, :size => 20
    @doc.move_down 16*2

    feature_image
    
    @doc.text "Grid Connect PV User Manual", :align => :center, :size => 16
    
    @doc.text "#{@manual.client_name} \n#{@manual.client_address} \n#{@manual.client_suburb}", :align => :center

    @doc.text_box "#{@manual.user.full_name}\nAccreditation No. #{@manual.user.accreditation}", :at => [0, 16*5], :width => @doc.bounds.width, :style => :bold, :align => :center
    
    @doc.text_box "This document has been prepared as a reference and maintenance manual for the owner of the above PV power system.", :at => [50, 16*2], :width => @doc.bounds.width - 100, :align => :center
  end
  
  def feature_image
    if @manual.feature_image && @manual.feature_image.file?
      uri = @manual.feature_image.file.url(:original)
      cover_image = open(uri)
      
      # FastImage/Prawn has a bug that won't let us pass in cover_image
      width, height = FastImage.size(uri)
      
      if width && height
        print_width = width * dpi_ratio
        print_height = height * dpi_ratio
      
        if print_width > @doc.bounds.width
          @doc.image cover_image, :width => @doc.bounds.width
          @doc.move_down 16
        else
          left_pos = (@doc.bounds.width - print_width) / 2
          @doc.image cover_image, :at => [left_pos, @doc.cursor], :scale => dpi_ratio
          @doc.move_down print_height + 16
        end
      end
    end
  end

  def dpi_ratio
    (72.0/300)
  end
end