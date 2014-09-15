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

def add_boston(agent, root_url)
  new_city_url = URI.join(root_url, 'cities/new')
  
  page = agent.get new_city_url
  form = page.form(action: /\/cities$/)
  
  form.field(name: /name/).value = 'Boston'
  form.field(name: /latitude/).value = '42.3133734'
  form.field(name: /longitude/).value = '-71.057157'
  form.click_button
end

def add_boston_venues(agent, venues_datafile, root_url)
  businesses = JSON.load File.read(venues_datafile)
  new_venue_url = URI.join(root_url, 'venues/new')
  
  businesses.each do |business|
    next unless /boston/i =~ business['city']
    
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
    form.field(name: /lat/).value = business['location']['lat']
    form.field(name: /long/).value = business['location']['long']
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

login_as_admin(agent, ARGV[2], ARGV[1])
add_boston(agent, ARGV[1])
add_boston_venues(agent, ARGV[0], ARGV[1])


