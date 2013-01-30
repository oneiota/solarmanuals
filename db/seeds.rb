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