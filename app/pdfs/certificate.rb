class Certificate
  
  def initialize(document, manual)
    @doc = document
    @manual = manual
    
    @line_size = 3
    @line_length = 10
    
    
  end
  
  def draw
    
    horizontal_sine_curve(@doc.cursor, 0, @doc.bounds.width, -1)
    horizontal_sine_curve(@doc.cursor-@doc.bounds.height, 0, @doc.bounds.width, 1)
    vertical_sine_curve(0, 0, @doc.bounds.height, 1)
    vertical_sine_curve(@doc.bounds.width, 0, @doc.bounds.height, -1)
    
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