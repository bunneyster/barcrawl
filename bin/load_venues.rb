#!/usr/bin/env ruby

require 'json'
require 'mechanize'
require 'uri'

unless ARGV.length == 2
  puts "Usage: load_venues path/to/data http://site.com/" 
  exit 1
end

businesses = JSON.load File.read(ARGV[0])

agent = Mechanize.new
new_venue_url = URI.join(ARGV[1], 'venues/new')

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
  form.field(name: /lat/).value = business['location']['lat']
  form.field(name: /long/).value = business['location']['long']
  form.field(name: /image_url/).value = business['image_url']
  form.field(name: /stars/).value = business['rating']['stars']
  form.field(name: /rating/).value = business['rating']['count']
  form.field(name: /yelp_id/).value = business['yelp_id']
    
  form.click_button
end
