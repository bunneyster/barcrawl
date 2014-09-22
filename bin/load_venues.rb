#!/usr/bin/env ruby

require 'json'
require 'mechanize'
require 'uri'

unless ARGV.length == 3
  puts "Usage: load_venues path/to/data http://site.com/ path/to/admin/data" 
  exit 1
end

def login_as_admin(agent, admin_datafile, root_url)
  lines = File.readlines(admin_datafile)
  email, password = lines[0].chomp, lines[1].chomp
  
  page = agent.get root_url
  form = page.form(action: /^\//)
  
  form.field(name: /email/).value = email
  form.field(name: /password/).value = password  
  form.click_button
end

def add_cities(cities, agent, root_url)
  new_city_url = URI.join(root_url, 'cities/new')
  
  cities.each do |city|
  
    page = agent.get new_city_url
    form = page.form(action: /\/cities$/)  
    form.field(name: /name/).value = city[:name]
    form.field(name: /latitude/).value = city[:lat]
    form.field(name: /longitude/).value = city[:lng]
    form.click_button
  end
end

def add_venues(agent, venues_datafile, root_url)
  businesses = JSON.load File.read(venues_datafile)
  new_venue_url = URI.join(root_url, 'venues/new')
  
  businesses.each do |business|
    
    page = agent.get new_venue_url
    form = page.form(action: /\/venues$/)
    form.field(name: /name/).value = business['name']
    city_option = form.field(name: /city_id/).option(text: business['city'])
    if city_option 
      city_option.select
    else
      p business['city']
      p business
      next
    end
    if business['location']
      form.field(name: /lat/).value = business['location']['lat']
      form.field(name: /long/).value = business['location']['long']
    else
      next
    end
    form.field(name: /address/).value = business['display_address'].join(' ')
    form.field(name: /phone_number/).value = business['phone']
    form.field(name: /image_url/).value = business['image_url']
    form.field(name: /stars/).value = business['rating']['stars']
    form.field(name: /rating/).value = business['rating']['count']
    form.field(name: /yelp_id/).value = business['yelp_id']
      
    form.click_button
  end
end


agent = Mechanize.new

cities = [
  { name: 'Boston', lat: '42.3133734', lng: '-71.057157' },
  { name: 'New York', lat: '40.7056308', lng: '-73.9780035' },
  { name: 'San Francisco', lat: '37.7577', lng: '-122.4376' }
]

login_as_admin(agent, ARGV[2], ARGV[1])
add_cities(cities, agent, ARGV[1])
add_venues(agent, ARGV[0], ARGV[1])


