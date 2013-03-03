module ApplicationHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''
    link_to link_text, link_path, :class => class_name
  end
  
  def nicetime(time)
    time.strftime("%B %-d, %Y")
  end
  
  def currency(cents)
    "$%.2f" % (cents / 100.0) + " AUD"
  end
  
  def format_card(number)
    # split into strings 4 characters long
    number.scan(/.{4}/).join("-").downcase
  end
  
  # http://railscasts.com/episodes/196-nested-model-form-revised?view=asciicast
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
end
