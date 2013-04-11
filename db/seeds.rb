# encoding: utf-8

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
  
if Message.count == 0
  
  messages = [
  "Make manuals faster!<br/>You can duplicate saved manuals for installs that have similar details. Simply hit 'My Installs' to view your saved manuals, then select 'Duplicate' next to the manual you wish to copy", 
  "Did you know that installers are liable to provide complete documentaion to all customers for jobs completed from October 2012 onwards"
  ]

  messages.each do |message|
    params = { content: message }
    Message.create! params
    puts "created : " + message
  end
end

if Checklist.count == 0

  checklist_qs = [
  "Panel warranties","Inverter warranties","Array frame engineering certificate for wind and mechanical loading","Certificate of safety and compliance issued by system installer or designer","Commissioning sheet and installation checklist <strong class='help boldweight'><a href='http://www.solaraccreditation.com.au/installerresources/formsandchecklists.html' target='_blank' title='CEC Commissioning sheet and installation checklist'>- available for download here</a></strong>","Any additional state based requirements"
  ]

  checklist_qs.each do |checklist|
    params = { question: checklist }
    Checklist.create! params
  end
end

if ChecklistGroup.count == 0
  
  checklist_groups = {
  
    "General" => 
      [
        "WARNING: Where short circuit currents are required, follow AS/NZS 5033 Appendix D for the steps that shall be undertaken to measure the short circuit current safely.<br/><br/>NOTE: Some projects require that short circuit currents are recorded as part of the contractual commissioning; otherwise a record of the actual operating current of each string is sufficient. This could be done by using the meter on the inverter or by using a clamp meter when the system is operational.",
        []
      ],
    
    "Insulation Resistance Measurement" => 
      [
        "WARNING: PV array dc circuits are live during daylight and, unlike a conventional ac circuit, cannot be isolated before performing this test.<br/>Follow AS/NZS 5033 Appendix D4 for the steps that shall be undertaken to measure the insulation resistance safely.",
        []
      ],
    
    "Installation Details" => 
      [
        "",
        [
          ["Number of MPPTs?","","text_field"]
        ]
      ],
    
    "PV Arrays" => 
      [
        "",
        [
          ["Array frames are certified to AS1170.2 for installation location?","","check_box"],
          ["Array frames are installed to manufacturer’s instructions?","","check_box"],
          ["No galvanically dissimilar metals are in contact with the array frames or supports?","","check_box"],
          ["Roof penetrations are suitably sealed and weatherproofed?","","check_box"],
          ["PV wiring losses are less than 3%at the maximum current output of the array?","","check_box"],
          ["Where PV array comprise multiple strings-string protection has been provided?","","check_box"],
          ["Wiring is protected from mechanical damage and is appropriately supported?","","check_box"],
          ["Weatherproof PV array isolator mounted adjacent to each array?","(Rating:................................Vdc, ................Adc)","check_box"]
        ]
      ],
    
    "LV DC and AC INSTALLATION" => 
      [
        "",
        [
          ["All low voltage wiring has been installed by a licensed electrical tradesperson?","","check_box"],
          ["All wiring has been tested and approved by qualified electrical tradesperson?","","check_box"]
        ]
      ],
    
    "Inverter" => 
      [
        "",
        [
          ["PV array isolator mounted adjacent to the inverter?","(Rating:......................................Vdc, ................Adc)","check_box"],
          ["Isolator is mounted on output of the inverter?","(where required)","check_box"],
          ["Lockable AC circuit breaker mounted within the switchboard to act as the inverter main switch for the PV/inverter system?","(Rating ........... A )","check_box"],
          ["Inverter is installed as per manufacturer’s specification?","","check_box"],
          ["Inverter ceases supplying power within two seconds of a loss of AC mains?","","check_box"],
          ["Inverter does not resume supplying power until mains have been present for more than 60 seconds?","","check_box"]
        ]
      ],
    
    "Continuity Check" => 
      [
        "",
        [
          ["Circuit checked","(record a description of the circuit)","text_field"],
          ["Continuity of all string, sub-array and array cables?","","check_box"],
          ["Continuity of all earth connections?","(including module frame)","check_box"]
        ]
      ],
    
    "System Check" => 
      [
        "WARNING: IF A STRING IS REVERSED AND CONNECTED TO OTHERS, FIRE MAY RESULT. IF POLARITY IS REVERSED AT THE INVERTER DAMAGE MAY OCCUR TO THE INVERTER.",
        [
          ["Sub-arrays where required - N/A","We do not currently support sub-array systems",""],
          ["PV array at PV array switch-disconnector - Voltage","V","text_field"],
          ["PV array at PV array switch-disconnector - Short Circuit","A","text_field"],
          ["PV array at PV array switch-disconnector - Operating Current","A","text_field"],
          ["Irradiance at time of recording the current","W/m2","text_field"]
        ]
      ],
    
    "INSULATION RESISTANCE MEASUREMENTS" => 
      [
        "<img src='/assets/insulation_resistance_table.gif' title='Minimum insulation resistance' alt='Minimum insulation resistance'/>",
        [
          ["Array positive to earth","MΩ","text_field"],
          ["Array negative to earth","MΩ","text_field"]
        ]
      ],
    
    "SIGNAGE (AS 4777)" => 
      [
        "",
        [
          ["On switchboard to which inverter is directly connected?","<img src='/assets/AS4777_1.gif'/>","check_box"],
          ["Is permanently fixed at the main switch?","<img src='/assets/AS4777_2.gif'/>","check_box"],
          ["Is permanently fixed at the solar main switch?","<img src='/assets/AS4777_3.gif'/>","check_box"],
          ["If the solar system is connected to a distribution board then the following sign is located on main switchboard and all intermediate distribution boards?","<img src='/assets/AS4777_4.gif'/>","check_box"]
        ]
      ],
    
    "SIGNAGE (AS/NZS 5033)" => 
      [
        "",
        [
          ["Is permanently fixed on array junction boxes (black on yellow)?","<img src='/assets/ASNZS5033_1.gif'/>","check_box"],
          ["Fire emergency information is permanently fixed on the main switchboard and/or meter box (if not installed together)?","<img src='/assets/ASNZS5033_2.gif'/>","check_box"],
          ["PV DC isolation is clearly identified?","<img src='/assets/ASNZS5033_3.gif'/>","check_box"],
          ["Is placed adjacent to the inverter when multiple isolation/disconnection devices are used that are not ganged together?","<img src='/assets/ASNZS5033_5.gif'/>","check_box"],
          ["Exterior surface of wiring enclosures labelled ‘SOLAR’?","<img src='/assets/ASNZS5033_4.gif'/>","check_box"],
          ["Shutdown procedure is permanently fixed at inverter and/or on main switchboard?","","check_box"],
          ["Any other signage as required by the local electricity distributor?","","check_box"]
        ]
      ]
  }
  
  
  puts checklist_groups
  
  checklist_groups.each do |title, group_array|
    
    description, items = group_array
    
    params = { name: title, description: description }
    
    group = ChecklistGroup.create! params
    
    puts "Created #{title}"
    
    items.each do |item_array|
      label, helper, field_type = item_array
      
      params = { 
        :checklist_group_id => group.id,
        :label => label,
        :helper => helper,
        :field_type => field_type
      }
      
      ChecklistItem.create params
      puts "\tCreated #{label}"
    end
    
  end
end

















  