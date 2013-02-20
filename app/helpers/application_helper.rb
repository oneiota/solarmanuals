module ApplicationHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
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
  
end
