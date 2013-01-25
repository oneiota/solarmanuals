class Diagram
  def initialize(document, manual)
    @doc = document
    @manual = manual
    
    
    @modules_width = 200
    @modules_left = 300
    @left = 0
    
  end
  
  def draw
    @start_y = @doc.cursor - 30
    
    modules
    isolators
    inverter
    switch_board
  end
  
  def modules
    @doc.stroke do
      @doc.rectangle [@left + @modules_left, @start_y], @modules_width, 120
    end
    
    data = [
      {
        :text => "Solar Modules\n",
        :styles => [:bold]
      },
      {
        :text => "#{@manual.panels_number} x #{@manual.panels_brand} 245W",
        :styles => [:bold]
      },
      {
        :text => " panels\nModel: "
      },
      {
        :text => "#{@manual.panels_model}\n",
        :styles => [:bold]
      },
      {
        :text => "Total: "
      },
      {
        :text => "#{@manual.system_watts}W Array",
        :styles => [:bold]
      }
    ]
    
    @doc.formatted_text_box data, :at => [@left + @modules_left + 20, @start_y - 20], :width => 160, :height => 100
    
  end
  
  def isolators
    gap = 40
    left = @left + @modules_left
    @top = @start_y - gap
    
    # first two lines
    @doc.stroke do
      @doc.move_to [left, @top]
      @doc.line_to [left - 40, @top]
      @doc.move_to [left, @top - gap]
      @doc.line_to [left - 40, @top - gap]
    end
    
    # first switch
    left = left - 40
    @doc.fill_ellipse [left, @top], 4
    @doc.fill_ellipse [left, @top - gap], 4
    @doc.stroke do
      @doc.move_to [left, @top]
      @doc.line_to [left - 20, @top + 20]
      @doc.move_to [left, @top - gap]
      @doc.line_to [left - 20, @top - 20]
    end
    

    # lines into corner
    left = left - 30
    top_left = [left - 100 - gap, @top]
    @doc.stroke do
      # outer line
      @doc.move_to [left, @top]
      @doc.line_to top_left
      @doc.line_to [left - 100 - gap, @top - gap - 60]
      
      # inner line
      @doc.move_to [left, @top - gap]
      @doc.line_to [left - 100, @top - gap]
      @top = @top - gap - 60
      @doc.line_to [left - 100, @top]
    end
    
    # second switch
    left = left - 100
    @doc.fill_ellipse [left, @top], 4
    @doc.fill_ellipse [left - gap, @top], 4
    @doc.stroke do
      # inner line
      @doc.move_to [left, @top]
      @doc.line_to [left - 20, @top - 20]
      # outer line
      @doc.move_to [left - gap, @top]
      @doc.line_to [left - gap - 20, @top - 20]
      
      # inner
      @top = @top - 30
      @doc.move_to [left, @top]
      @doc.line_to [left, @top - 50]
      
      @doc.move_to [left - gap, @top]
      @doc.line_to [left - gap, @top - 50]
      @top = @top - 50
    end
  end
  
  def inverter
    width = 160
    height = 100
    
    @doc.stroke do
      # rectangle / line
      @doc.rectangle [@left + 30, @top], width, height
      @doc.move_to [@left + 30 + width, @top]
      @doc.line_to [@left + 30, @top - height]
      
      @doc.move_to [@left + 50, @top - 20]
      @doc.line_to [@left + 115, @top - 20]
    end
    
    # DC dash
    @doc.dash 5
    @doc.stroke do
      @doc.move_to [@left + 50, @top - 30]
      @doc.line_to [@left + 115, @top - 30]
    end
    
    @doc.dash 0
    # AC curve
    @doc.stroke do
      curve_left = @left + 115
      @doc.move_to [curve_left, @top - 80]
      
      @doc.curve_to [curve_left + 20, @top - 60], :bounds => [[curve_left + 10, @top - 80], [curve_left + 10, @top - 60]]
      @doc.curve_to [curve_left + 40, @top - 80], :bounds => [[curve_left + 30, @top - 60], [curve_left + 30, @top - 80]]
      @doc.curve_to [curve_left + 60, @top - 60], :bounds => [[curve_left + 50, @top - 80], [curve_left + 50, @top - 60]]
    end
    
    @top = @top - height
  end
  
  def switch_board
    left = @left + 110
    # single line
    @doc.stroke do
      @doc.move_to [left, @top]
      @doc.line_to [left, @top - 50]
      @doc.rectangle [left - 10, @top - 50], 20, 50
      @doc.move_to [left, @top - 100]
      @doc.line_to [left, @top - 150]
      @doc.rectangle [@left + 30, @top - 150], 160, 100
    end
    
    @doc.text_box "Switch Board", :style => :bold, :at => [@left + 40, @top - 195], :width => 140, :align => :center
  end
  
end