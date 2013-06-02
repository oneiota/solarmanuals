class InstallationChecklist
  
  include ActionView::Helpers::SanitizeHelper
  
  def initialize(document, manual)
    @document = document
    @manual = manual
    
  end
  
  def draw
    
    ChecklistGroup.all.each do |group|
      
      @document.header3 group.name
      @document.text strip_tags(group.description), :size => 9
      
      table_buffer = []
      
      group.checklist_items.each do |item|
        
        response = @manual.checklist_responses.where(:checklist_item_id => item.id).first
        
        if item.image_url
          table_buffer << item.image_url
        end
        
        table_buffer << item.label
        
        response_string = " - "
        
        if response          
          response_string = response.response.empty? ? " - " : response.response # prevent hiding column
          if response.na
            response_string = "N/A"
          else
            if item.field_type == "check_box"
              if response.response == "1"
                response_string = "Yes"
              end
              if response.response == "0"
                response_string = "No"
              end
            end
          end
        end
        
        table_buffer << response_string + "|\n"
        
      end
      
      unless table_buffer.empty?
        @document.table_from_string table_buffer.join('|')
      end
      
    end
    
  end
  
end



# create_table "checklist_groups", :force => true do |t|
#   t.string   "name"
#   t.text     "description"
#   t.datetime "created_at",  :null => false
#   t.datetime "updated_at",  :null => false
# end
# 
# create_table "checklist_items", :force => true do |t|
#   t.integer  "checklist_group_id"
#   t.text     "label"
#   t.string   "helper"
#   t.string   "field_type"
#   t.datetime "created_at",         :null => false
#   t.datetime "updated_at",         :null => false
# end
# 
# create_table "checklist_responses", :force => true do |t|
#   t.integer  "manual_id"
#   t.integer  "checklist_item_id"
#   t.string   "response"
#   t.datetime "created_at",        :null => false
#   t.datetime "updated_at",        :null => false
# end
