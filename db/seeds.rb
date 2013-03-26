# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if State.count == 0
  states = ["Queensland", "New South Wales", "Victoria", "Tasmania", "South Australia", "Northern Territory", "Western Australia"]
  states.each do |state|
    params = { name: state }
    if state == "Queensland"
      params[:disabled] = false
    end
    State.create! params
  end
end
  
Message.destroy_all
  
messages = [
"Make manuals faster!<br/>You can duplicate saved manuals for installs that have similar details. Simply hit 'My Installs' to view your saved manuals, then select 'Duplicate' next to the manual you wish to copy", 
"Did you know that installers are liable to provide complete documentaion to all customers for jobs completed from October 2012 onwards"
]

messages.each do |message|
  params = { content: message }
  Message.create! params
  puts "created : " + message
end

Checklist.destroy_all

checklist_qs = [
"Panel warranties","Inverter warranties","Array frame engineering certificate for wind and mechanical loading","Certificate of safety and compliance issued by system installer or designer","Commissioning sheet and installation checklist <strong class='help boldweight'><a href='http://www.solaraccreditation.com.au/installerresources/formsandchecklists.html' target='_blank' title='CEC Commissioning sheet and installation checklist'>- available for download here</a></strong>","Any additional state based requirements"
]

checklist_qs.each do |checklist|
  params = { question: checklist }
  Checklist.create! params
end