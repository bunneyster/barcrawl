# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = Location.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create!(name: 'User Name',
             email: 'asdf@asdf.com',
             password: 'asdf',
             password_confirmation: 'asdf')
             
City.delete_all
City.create!(name: 'Boston',
             latitude: 42.3133735,
             longitude: -71.0571571)
City.create!(name: 'New York',
             latitude: 40.7056308,
             longitude: -73.9780035)
City.create!(name: 'San Francisco',
             latitude: 37.7577,
             longitude: -122.4376)
City.create!(name: 'Seoul',
             latitude: 37.5651,
             longitude: 126.98955)             

Tour.delete_all
Tour.create!(name: "User Name's Tour 1",
             city: City.where(name: 'Boston').first,
             starting_at: 1.week.from_now,
             organizer: User.where(email: 'asdf@asdf.com').first)
Tour.create!(name: "User Name's Tour 2",
             city: City.where(name: 'New York').first,
             starting_at: 2.weeks.from_now,
             organizer: User.where(email: 'asdf@asdf.com').first)
Tour.create!(name: "User Name's Tour 3",
             city: City.where(name: 'San Francisco').first,
             starting_at: 3.weeks.from_now,
             organizer: User.where(email: 'asdf@asdf.com').first)       
