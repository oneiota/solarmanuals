class Diagram
  def initialize(document, manual)
    @doc = document
    @manual = manual
    
    
    @modules_width = 200
    @modules_left = 300
    @left = -30
    
    @inverter_top = 500 - ((@manual.panel_strings.count-1) * 60)
    @inverter_width = 160
    
    @ellipse_size = 2
    
  end
  
  def draw
    
    @start_y = @doc.cursor + ((@manual.panel_strings.count-1) * 10)
    
    if @manual.panel_strings.count <= 3
      multiple_modules
      multiple_isolators
    else
      modules
      isolators
    end
    inverter
    switch_board
  end
  
  def multiple_modules
    
    @manual.panel_strings.each_with_index do |string, index|
      
      top = @start_y - (90 * index)
      @doc.stroke do
        @doc.rectangle [@left + @modules_left, top], @modules_width, 80
      end
      
      data = [
        {
          :text => "#{string.number} x #{@manual.panels_watts}W",
          :styles => [:bold]
        },
        {
          :text => " panels\nModel: "
        },
        {
          :text => "#{@manual.panels_brand} #{@manual.panels_model}\n",
          :styles => [:bold]
        },
        {
          :text => "Total: "
        },
        {
          :text => "#{string.total}W Array \n#{string.total_volts} Volts DC, #{string.amps} Amps",
          :styles => [:bold]
        }
      ]
      
      @doc.formatted_text_box data, :at => [@left + @modules_left + 10, top - 10], :width => @modules_width - 20, :height => 80
      
    end
    
    @doc.text_box "#{@manual.panel_strings.count * 2} x #{@manual.isolator_type} Isolators", :at => [@left + @modules_left - 150, @start_y - 70]
    
  end
  
  def multiple_isolators
    
    @manual.panel_strings.each_with_index do |string, index|
    
      gap = 20
      left = @left + @modules_left
      @top = @start_y - 30 - (index * 90)
    
      # first two lines
      @doc.stroke do
        @doc.move_to [left, @top]
        @doc.line_to [left - 40, @top]
        @doc.move_to [left, @top - gap]
        @doc.line_to [left - 40, @top - gap]
      end
    
      # first switch
      left = left - 40
      @doc.fill_ellipse [left, @top], @ellipse_size
      @doc.fill_ellipse [left, @top - gap], @ellipse_size
      @doc.stroke do
        @doc.move_to [left, @top]
        @doc.line_to [left - 15, @top + 15]
        @doc.move_to [left, @top - gap]
        @doc.line_to [left - 15, @top - gap + 15]
      end
      
      
      left = left - 20
      corner_left = left - 100 - gap # default
      
      inverter_left = @left + 30
      if (@string_count = @manual.panel_strings.count) == 1
        corner_left = inverter_left + (@inverter_width / 2) + gap - (gap / 2) # middle
      else
        # space evenly across 
        space = (@inverter_width - gap - 60) / (@string_count - 1)
        corner_left = inverter_left + 30 + (space * index) + gap
      end
      
    
      # corner lines
      @doc.stroke do
        # outer line
        @doc.move_to [left, @top]
        @doc.line_to [corner_left - gap, @top]
        @doc.line_to [corner_left - gap, @inverter_top + 50]
      
        # inner line
        @doc.move_to [left, @top - gap]
        @doc.line_to [corner_left, @top - gap]
        @doc.line_to [corner_left, @inverter_top + 50]
      end
      
      left = corner_left
    
      # second switch
      @doc.fill_ellipse [left, @inverter_top + 50], @ellipse_size
      @doc.fill_ellipse [left - gap, @inverter_top + 50], @ellipse_size
      @doc.stroke do
        # inner line diagonal
        @doc.move_to [left, @inverter_top + 50]
        @doc.line_to [left - 15, @inverter_top + 35]
        # outer line diagonal
        @doc.move_to [left - gap, @inverter_top + 50]
        @doc.line_to [left - gap - 15, @inverter_top + 35]
      
        # inner lines to inverter
        @top = @inverter_top + 30
        @doc.move_to [left, @top]
        @doc.line_to [left, @top - 30]
      
        @doc.move_to [left - gap, @top]
        @doc.line_to [left - gap, @top - 30]
        @top = @top - 30
      end
      
    end
  end
  

  def modules
    @doc.stroke do
      @doc.rectangle [@left + @modules_left, @start_y], @modules_width, 60 + (@manual.panel_strings.count * 19)
    end
    
    if !@manual.panel_strings
      return
    end
    
    i = 0
    strings = @manual.panel_strings.inject("") do |result, str|
      i += 1
      "#{result}\n#{i.to_s}. #{str.number} panels: #{str.total_volts} V, #{str.amps} Amps"
    end
    
    data = [
      {
        :text => "#{@manual.panels_brand} #{@manual.panels_model} #{@manual.panels_watts}W",
        :styles => [:bold]
      },
      {
        :text => "\nStrings:"
      },
      {
        :text => strings,
        :styles => [:bold]
      }
    ]
    
    @doc.formatted_text_box data, :at => [@left + @modules_left + 15, @start_y - 15], :width => @modules_width - 30, :height => 60 + (@manual.panel_strings.count * 19)
    
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
    
    @side_left = @left + 90
    
    # lines into corner
    left = left - 30
    top_left = [@side_left, @top]
    @doc.stroke do
      # outer line
      @doc.move_to [left, @top]
      @doc.line_to top_left
      @doc.line_to [@side_left, @top - gap - 70]
      
      # inner line
      @doc.move_to [left, @top - gap]
      @doc.line_to [@side_left + gap, @top - gap]
      @top = @top - gap - 70
      @doc.line_to [@side_left + gap, @top]
    end
    
    @doc.text_box "#{@manual.isolator_type} Isolators", :at => [left - 70, @top + 20]
    
    # second switch
    
    @doc.fill_ellipse [@side_left + gap, @top], 4
    @doc.fill_ellipse [@side_left, @top], 4
    @doc.stroke do
      # inner line diagonal
      @doc.move_to [@side_left, @top]
      @doc.line_to [@side_left - 20, @top - 20]
      # outer line diagonal
      @doc.move_to [@side_left + gap, @top]
      @doc.line_to [@side_left + gap - 20, @top - 20]
      
      # inner lines to inverter
      @top = @top - 20
      @doc.move_to [@side_left, @top]
      @doc.line_to [@side_left, @top - 30]
      
      @doc.move_to [@side_left + gap, @top]
      @doc.line_to [@side_left + gap, @top - 30]
      @top = @top - 30
    end
    
    @inverter_top = @top
    
  end
  
  def inverter
    width = 160
    height = 100
    
    @top = @inverter_top
    
    @doc.stroke do
      # rectangle / line
      @doc.rectangle [@left + 30, @top], width, height
      @doc.move_to [@left + 30 + width, @top]
      @doc.line_to [@left + 30, @top - height]
      
      @doc.move_to [@left + 50, @top - 20]
      @doc.line_to [@left + 115, @top - 20]
    end
    
    
    text = [
      {
        :text => "Inverter -\n",
        :styles => [:regular]
      },
      {
        :text => "#{@manual.inverter_brand} #{@manual.inverter_series} #{@manual.inverter_model}\n",
        :styles => [:bold]
      },
      {
        :text => "Output: ",
        :styles => [:regular]
      },
      {
        :text => "#{@manual.inverter_output}kW",
        :styles => [:bold]
      }
    ]
    
    @doc.formatted_text_box text, :at => [@left + width + 50, @top - 10]
    
    # DC dash
    @doc.stroke do
      horizontal_dash @top - 30, @left + 50, @left + 115, 5
    end
    
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
  
  def horizontal_dash(at, from, to, dashes)
    total_length = to - from
    dash_length = total_length / (dashes * 2 + 1).to_f
    x_pos = 0
    (0..dashes).each do |dash|
      @doc.move_to [from + x_pos * dash_length, at]
      @doc.line_to [from + (x_pos+1) * dash_length, at]
      x_pos += 2
    end
  end
  
  def switch_board
    
    left = @left + 110
    # single line
    @doc.stroke do
      @doc.move_to [left, @top]
      @doc.line_to [left, @top - 80]
      @doc.rectangle [left - 10, @top - 80], 20, 50
      @doc.move_to [left, @top - 130]
      @doc.line_to [left, @top - 210]
      @doc.rectangle [@left + 30, @top - 210], 160, 100
    end
    
    @doc.text_box "Switch Board", :style => :bold, :at => [@left + 40, @top - 255], :width => 140, :align => :center
    
    label3 = "SOLAR\nSUPPLY\nMAIN\nSWITCH"
    @doc.text_box label3, :at => [left + 40, @top - 70], :align => :center, :width => 80, :style => :bold
    @doc.stroke do
      @doc.rectangle [left + 40, @top - 55], 80, 95
    end
    
    @top = 200
    
    label1 = "WARNING DC VOLTAGE\nOPEN CIRCUIT VOLTAGE\nSHORT CIRCUIT CURRENT"
    @doc.text_box label1, :at => [@left + 300, @top], :style => :bold, :align => :center, :width => 200
    @doc.stroke do
      @doc.rectangle [@left + 300, @top + 15], 200, 75
    end
    
    label2 = "WARNING DUAL SUPPLY\nISOLATE BOTH SOLAR AND NORMAL SUPPLY BEFORE WORKING ON SWITCHBOARD"
    @doc.text_box label2, :at => [@left + 300, @top - 100], :width => 200, :style => :bold, :align => :center
    @doc.stroke do
      @doc.rectangle [@left + 300, @top - 85], 200, 95
    end
    
  end
  
end