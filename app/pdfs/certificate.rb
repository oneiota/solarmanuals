class Certificate
  
  def initialize(document, manual)
    @doc = document
    @manual = manual
    
    @line_size = 3
    @line_length = 10
    
  end
  
  
  
  def draw
    
    # borders
    horizontal_sine_curve(@doc.cursor-1, 0, @doc.bounds.width-4, -1)
    horizontal_sine_curve(@doc.cursor-@doc.bounds.height+10, 0, @doc.bounds.width-4, 1)
    vertical_sine_curve(0, 10, @doc.bounds.height-4, 1)
    vertical_sine_curve(@doc.bounds.width-4, 10, @doc.bounds.height, -1)
    
    @doc.move_down 35
    
    @doc.text_box @manual.user.company, :style => :bold, :at => [30, @doc.cursor], :size => 21, :width => @doc.bounds.width-60, :align => :center
    @doc.move_down (16*2)
    
    # @doc.text_box "Lic No: 35641", :at => [160, @doc.cursor], :style => :bold
    @doc.text_box "ABN: #{@manual.user.abn}", :at => [0, @doc.cursor], :style => :bold, :width => @doc.bounds.width, :align => :center
    
    @doc.move_down 32
    
    @doc.text_box "#{@manual.user.company_address} #{@manual.user.company_suburb}\nPhone #{@manual.user.company_phone}  Fax: #{@manual.user.company_fax}\nEmail: #{@manual.user.contact_email}", :at => [30, @doc.cursor], :width => @doc.bounds.width-60, :align => :center
    
    @doc.move_down (16*5)
    
    @doc.move_to [30, @doc.cursor]
    @doc.stroke do
      @doc.line_to [@doc.bounds.width - 30, @doc.cursor]
    end
    
    @doc.move_down 16
    
    @doc.text_box "CERTIFICATE OF TESTING AND COMPLIANCE", :at => [0, @doc.cursor], :size => 21, :style => :bold, :align => :center, :width => @doc.bounds.width
    
    @doc.move_down (16*2)
    
    @doc.move_to [30, @doc.cursor]
    @doc.stroke do
      @doc.line_to [@doc.bounds.width - 30, @doc.cursor]
    end
    
    @doc.move_down (16*3)
    
    @doc.text_box "Work performed for:\nAddress:", :at => [30, @doc.cursor]
    
    @doc.text_box "#{@manual.client_name} \n#{@manual.client_address} \n#{@manual.client_suburb}", :at => [150, @doc.cursor], :style => :bold
    
    @doc.move_down (16*4)
    
    @doc.text_box "List of all work done:", :at => [30, @doc.cursor]
    @doc.move_down 16*2
    
    @doc.line_width = 0.5
    @doc.stroke_color 0, 0, 0, 60
    @doc.stroke do
      (0..6).each do |i|
        y = @doc.cursor - i * 24
        @doc.move_to [30, y]
        @doc.line_to [@doc.bounds.width - 30, y]
      end
    end
    
    @doc.move_down 16*11
    
    @doc.formatted_text_box [
      { :text => "Date of test:  "},
      { :text => "#{@manual.inspection_date.strftime('%e / %-m / %y')}", :styles => [:bold] },
    ], :at => [30, @doc.cursor]
    
    @doc.formatted_text_box [
      { :text => "Electrical contractor licence number:  " },
      { :text => @manual.contractor_licence.to_s, :styles => [:bold] }
    ], :at => [170, @doc.cursor]
    
    @doc.move_down 16
    
    @doc.formatted_text_box [
      { :text => "Name on contractor licence:  " },
      { :text => @manual.contractor_licence_name, :styles => [:bold] }
    ], :at => [30, @doc.cursor]
    
    @doc.move_down 16
    
    @doc.formatted_text_box [
      { :text => "Electrical contractor phone number:  " },
      { :text => @manual.contractor_phone, :styles => [:bold] }
    ], :at => [30, @doc.cursor]
    
    @doc.move_down 16 * 2
    
    @doc.text_box "This certifies that the electrical instllation, to the extent it is affected by the electrical work has been tested to ensure that it is electrically safe and is in accordance with the requirement of the wiring rules and any other standard applying udner the Electrical Safety Regulation 2002 to the electrical installation.", :at => [30, @doc.cursor], :width => @doc.bounds.width - 60
    
    @doc.move_down 16*5
    
    @doc.formatted_text_box [
      { :text => "Name:  " },
      { :text => @manual.contractor_name, :styles => [:bold] }
    ], :at => [30, @doc.cursor]
    
    @doc.text_box "Signature:", :at => [200, @doc.cursor]
    
    @doc.stroke do
      y = @doc.cursor - 12
      @doc.move_to [260, y]
      @doc.line_to [@doc.bounds.width - 30, y]
    end
    
    @doc.move_down 16*2
    
    @doc.text_box "Date:", :at => [200, @doc.cursor]
    
    @doc.stroke do
      y = @doc.cursor - 12
      @doc.move_to [260, y]
      @doc.line_to [@doc.bounds.width - 30, y]
    end
    
    
  end
  
  # - from_top    |            -
  #    -          |          -
  #      \        |        |
  #---top--\-------------|-------
  #          -    |    -
  #            -  to_top
  # ----length----|
  #
  def horizontal_sine_curve(top, start_left, end_left, i)
    left = start_left
    size = @line_size
    length = @line_length
    
    @doc.move_to [left, top + (size * i)]
    @doc.stroke do
      while end_left > left
        
        to_top = top - (size * i)
        from_top = top + (size * i)
        
        @doc.curve_to [left + length, to_top], 
          :bounds => [
            # bezier points' X values are halfway between the points, 
            # and Y values are on the same level
            [left + (length / 2), from_top],
            [left + (length / 2), to_top]
          ]
        left += length
        i *= -1
      end
    end  
  end
  
  def vertical_sine_curve(left, start_top, end_top, i)
    top = start_top
    size = @line_size
    length = @line_length
        
    @doc.move_to [left + (size * i), top]
    @doc.stroke do
      while end_top > top
        
        to_left = left - (size * i)
        from_left = left + (size * i)
        
        @doc.curve_to [to_left, top + length], 
          :bounds => [
            # bezier points' X values are halfway between the points, 
            # and Y values are on the same level
            [from_left, top + (length / 2)],
            [to_left, top + (length / 2)]
          ]
        top += length
        i *= -1
      end
    end
  end
  
  
end