# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "seeding"
puts "generating 50 users"
user_array = []
50.times do
  user = User.new(
    email: Faker::Internet.email,
    password: 123123
  )
  user.save!
  user_array << user
end

puts "50 users created"
puts "generating 10 groups"
group_array = []
10.times do
  group = Group.new(
    name: Faker::JapaneseMedia::Doraemon.gadget
  )
  group.user = user_array.sample
  group.save!
end

puts "adding 3 users to each group"

Group.all.each do |group|
  ug = UserGroup.new
  ug.user = user_array.sample
  user_array.delete(ug.user)
  ug.group = group
  ug.save!
end

puts "done adding users to each group"

puts "10 groups generated"
puts "creating 2 events per group"

Group.all.each do |group|
  2.times do
    event = Event.new(
      name: "event",
      location: Faker::JapaneseMedia::Doraemon.location,
      start_date: Date.today,
      end_date: Date.today + 1,
      description: "Great event!"
    )
    event.group = group
    event.save!
  end
end

puts "20 events created"
