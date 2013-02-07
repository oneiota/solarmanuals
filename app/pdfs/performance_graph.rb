class PerformanceGraph
  
  def initialize(document, manual)
    
    @document = document
    @manual = manual
    
    # kw = 2.45
    kw = @manual.system_watts.to_i / 1000
    city = @manual.sunlight_city
    
    @data = Cities.data[city].map do |week|
      (week / 7) * kw * 0.75
    end
    
  end
  
  def draw_graph
    
    graph_max = @data.max.ceil
    
    graph_height = 250.0 # force float division
    graph_multiplier = graph_height / graph_max
    
    line_increment = graph_max / 10
    if line_increment < 1
      line_increment = 1
    end
        
    width = 480.0
    weeks = @data.length
    start_y = @document.cursor - 30
    graph_left = 20
    
    # draw horizontal lines
    @document.line_width = 0.5
    @document.stroke_color 0, 0, 0, 20
    @document.join_style = :round
    y_points = (0..graph_max).to_a.map{ |y| start_y - graph_height + y * graph_multiplier }
    y_points.each_with_index do |y, i|
      if i % line_increment == 0
        @document.stroke do
          @document.move_to [graph_left-5, y]
          @document.line_to [graph_left+width, y]
        end
      end
    end
    
    # left vertical line
    @document.stroke do
      @document.line [graph_left, start_y], [graph_left, start_y - graph_height]
    end
    
    # kWh labels
    @document.text_box "kWh", :at => [graph_left - 50, start_y - (graph_height/2)], :style => :bold
    (0..graph_max).to_a.each do |y|
      if y % line_increment == 0
        @document.text_box y.to_s, 
          :at => [graph_left - 30, start_y - graph_height + y * graph_multiplier + 3],
          :width => 20,
          :size => 8,
          :align => :right
      end
    end
    
    # week labels
    increment = width / 52
    (0..52).to_a.each_with_index do |week, i|
      @document.stroke do
        x = week * increment + graph_left
        @document.line [x, start_y - graph_height], [x, start_y - graph_height - 5]
      end
    end
    
    #month labels
    ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"].each_with_index do |month, i|
      @document.text_box month, 
        :at => [width / 12 * i + graph_left, start_y - graph_height - 15],
        :width => width / 12,
        :align => :center,
        :size => 8
    end
    
    # draw graph line
    @document.line_width = 3
    @document.stroke_color 0, 0, 0, 100
    i = 0
    points = @data.map do |week|
      val = [(width/(weeks-1)*i)+graph_left, (week*graph_multiplier)+start_y-graph_height]
      i += 1
      val
    end
    @document.stroke do
      @document.move_to points.first
      points.each_with_index do |point, i|
        next if point == points.first
        @document.line_to points[i]
      end
    end
    
    @document.move_down graph_height + 100    
  end
  
  def total_average
   round @data.inject{ |sum, el| sum + el }.to_f / @data.size
  end
  
  def max
    round @data.max
  end
  
  def min
    round @data.min
  end
  
  def yearly_total
   round @data.inject{ |sum, el| sum + (el * 7) }
  end
  
  def round(f)
     "%.2f" % f
  end

end