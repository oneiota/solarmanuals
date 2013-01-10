# encoding: UTF-8
require 'erb'

class DocumentPdf < Prawn::Document
  
  def initialize(manual)
    super()
    
    font_size 11
    default_leading 5
    @spacing = 11
    
    
    @manual = manual
    template = ERB.new(File.read(Rails.root + 'app/pdfs/manual.md.erb'))
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
  end
  
  def parse(buffer)
    if buffer.start_with? "#" then return header(buffer) end
    if buffer.start_with? "* " then return list(buffer) end
    if buffer.strip == "---" then return start_new_page end
    paragraph buffer
  end
  
  def paragraph(buffer)
    text buffer, :inline_format => true
    move_down @spacing
  end
  
  def header(buffer)
    if buffer.start_with? "# "
      header1(buffer)
    elsif buffer.start_with? "## "
      header2(buffer)
    elsif buffer.start_with? "### "
      header3(buffer)
    end
  end
  
  def header1(buffer)
    text buffer[2..-1], :size => 20, :style => :bold
  end
  
  def header2(buffer)
    text buffer[3..-1], :size => 16, :style => :bold
  end
  
  def header3(buffer)
    text buffer[4..-1], :size => 12, :style => :bold
  end
  
  def list(buffer)
    # create nested array with bullets
    # then create a borderless table
    
    arr = []
    line_buffer = ""
    buffer.each_line do |line|
      if line.start_with? "* "
        line_buffer += line
      else
        line_buffer += line
        arr << ["•", line_buffer[2..-1]]
        line_buffer = ""        
      end
    end
    arr << ["•", line_buffer[2..-1]]
    
    table arr, :cell_style => { :borders => [] }
    move_down @spacing
  end

  
end