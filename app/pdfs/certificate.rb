class Certificate
  
  def initialize(document, manual)
    @doc = document
    @manual = manual
    
    @line_size = 3
    @line_length = 10
    
    
  end
  
  def draw
    
    @doc.start_new_page
    
    # borders
    horizontal_sine_curve(@doc.cursor-1, 0, @doc.bounds.width-4, -1)
    horizontal_sine_curve(@doc.cursor-@doc.bounds.height+10, 0, @doc.bounds.width-4, 1)
    vertical_sine_curve(0, 10, @doc.bounds.height-4, 1)
    vertical_sine_curve(@doc.bounds.width-4, 10, @doc.bounds.height, -1)
    
    @doc.move_down 35
    
    @doc.text_box @manual.user.company, :style => :bold, :at => [30, @doc.cursor], :size => 21, :width => @doc.bounds.width-60, :align => :center
    @doc.move_down (16*2)
    
    @doc.text_box "Lic No: 35641", :at => [160, @doc.cursor], :style => :bold
    @doc.text_box "ABN: 43 067 209 778", :at => [260, @doc.cursor], :style => :bold
    
    @doc.move_down 32
    
    @doc.text_box "6/887 Ann St Fortitude Valley\nPh: 0411693644  Fax: 07 123456789\nEmail: test@example.com", :at => [30, @doc.cursor], :width => @doc.bounds.width-60, :align => :center
    
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