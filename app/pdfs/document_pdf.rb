# encoding: UTF-8
require 'erb'
    
class DocumentPdf < Prawn::Document
  
  def initialize(options, manual)
    options[:margin] = 60
    super(options)
    
    font_size 11
    default_leading 5
    @spacing = 11
    
    
    @manual = manual
    @graph = PerformanceGraph.new(self, @manual)
    @diagram = Diagram.new(self, @manual)
    @certificate = Certificate.new(self, @manual)
    @cover = Cover.new(self, @manual)
    @checklist = InstallationChecklist.new(self, @manual)
    
    template = ERB.new(File.read(Rails.root.join('app/pdfs/manual.md.erb')))
    result = template.result(binding)
    
    # append line to buffer until we hit a blank line
    # then parse buffer as 1 or more lines
    # since lists and tables deal with more than 1 line
    buffer = ""
    result.each_line do |line|
      unless line.strip == ""
        buffer += line
      else
        parse(buffer)
        buffer = ""
      end
    end
    # parse left over buffer for end of file
    parse(buffer) unless buffer.empty? 
    
    string = "<page> of <total>"
    options = { 
      :at => [0, 0],
      :width => bounds.width,
      :align => :center,
      :start_count_at => 2,
      :page_filter => lambda{ |pg| pg > 1 && pg != 11 }
    }
    
    number_pages string, options
    
    # attach PDFs
    
    @manual.pdfs.each do |pdf|
      begin
        go_to_page(page_count)
      
        pdf_url = pdf.file(:processed)
        new_pdf = open(pdf_url)
        template_page_count = count_pdf_pages(new_pdf)
      
        (1..template_page_count).each do |template_page_number|
          start_new_page(:template => new_pdf, :template_page => template_page_number)
        end
      rescue
        next
      end
    end
    
    
  end
  
  def parse(buffer)
    if buffer.start_with? "#" then return header(buffer) end
    if buffer.start_with? "* " then return list(buffer) end
    if buffer.start_with? "|" then return table_from_string(buffer) end
    if buffer.strip == "---" then return start_new_page end
    if buffer.start_with? "= " then return call_function(buffer) end
    paragraph buffer
  end
  
  def paragraph(buffer)
    text buffer, :inline_format => true
    move_down @spacing
  end
  
  def header(buffer)
    if buffer.start_with? "# "
      header1(buffer[2..-1])
    elsif buffer.start_with? "## "
      header2(buffer[3..-1])
    elsif buffer.start_with? "### "
      header3(buffer[4..-1])
    end
  end
  
  def header1(buffer)
    text buffer, :size => 20, :style => :bold
  end
  
  def header2(buffer)
    text buffer, :size => 16, :style => :bold
  end
  
  def header3(buffer)
    text buffer, :size => 11, :style => :bold
  end
  
  def list(buffer)
    # create nested array with bullets
    # then create a borderless table
    arr = []
    buffer.each_line do |line|
      if line.start_with? "* "
        arr << ["•", line[2..-1]]
      else
        arr << ["", line]
      end
    end
    
    table arr, :cell_style => { :borders => [], :padding => 2, :inline_format => true }
    move_down @spacing
  end
  
  def table_from_string(buffer)
    arr = []
    buffer.each_line do |line|
      arr << line.strip.split('|').reject{ |s| s.empty? }
    end
    table arr, :cell_style => { :inline_format => true, :border_width => 2 }, :width => bounds.width
    move_down @spacing * 2
  end
  
  def call_function(buffer)
    method_name = buffer[2..-1].strip
    if self.respond_to?(method_name)
      send method_name
    else
    end
  end
  
  def draw_graph
    @graph.draw_graph
  end
  
  def draw_diagram
    @diagram.draw
  end
  
  def certificate
    @certificate.draw
  end
  
  def cover
    @cover.draw
  end
  
  def checklist_answers
    @checklist.draw
  end
  
  private

    def count_pdf_pages(pdf_file_path)
      pdf = Prawn::Document.new(:template => pdf_file_path)
      pdf.page_count
    end

  
end