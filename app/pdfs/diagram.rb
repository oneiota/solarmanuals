class Diagram
  def initialize(document, manual)
    @doc = document
    @manual = manual
    
    
    @modules_width = 230
    @modules_left = 320
    @left = -60
    
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
      @doc.rectangle [@left + @modules_left, @start_y], @modules_width, 60 + (@manual.panel_strings.count * 19)
    end
    
    if !@manual.panel_strings
      return
    end
    
    i = 0
    strings = @manual.panel_strings.inject("") do |result, str|
      i += 1
      "#{result}\n#{i.to_s}. #{str.number} panels: #{str.volts} V, #{str.amps} Amps"
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
    
    
    text = [
      {
        :text => "Inverter -\n",
        :styles => [:regular]
      },
      {
        :text => "#{@manual.inverter_brand}\n#{@manual.inverter_series}\n#{@manual.inverter_model}\n",
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
    
    label1 = "WARNING DC VOLTAGE\nOPEN CIRCUIT VOLTAGE\nSHORT CIRCUIT CURRENT"
    @doc.text_box label1, :at => [@left + 300, @top - 140], :style => :bold, :align => :center, :width => 200
    @doc.stroke do
      @doc.rectangle [@left + 300, @top - 125], 200, 75
    end
    
    label2 = "WARNING DUAL SUPPLY\nISOLATE BOTH SOLAR AND NORMAL SUPPLY BEFORE WORKING ON SWITCHBOARD"
    @doc.text_box label2, :at => [@left + 300, @top - 230], :width => 200, :style => :bold, :align => :center
    @doc.stroke do
      @doc.rectangle [@left + 300, @top - 215], 200, 95
    end
    
    label3 = "SOLAR\nSUPPLY\nMAIN\nSWITCH"
    @doc.text_box label3, :at => [left + 40, @top - 70], :align => :center, :width => 80, :style => :bold
    @doc.stroke do
      @doc.rectangle [left + 40, @top - 55], 80, 95
    end
    
  end
  
end