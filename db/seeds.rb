# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'securerandom'

75.times do |i|
  Trash.create(
  	title: "my title #{SecureRandom.hex(2)}",
  	description: "Lorem ipsum Anim in sit mollit cupidatat laborum incididunt qui ex cillum proident laborum est eiusmod consequat labore laboris elit ea veniam do fugiat nulla Excepteur est proident aliquip eiusmod labore Excepteur do esse nulla fugiat dolore.",
  	catetory_id: 0, 
  	created_by: 71,
  	updated_by: 71
  )

end

