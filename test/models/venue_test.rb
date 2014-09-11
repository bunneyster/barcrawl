require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  
  setup do
    @venue = Venue.new name: 'A Valid Venue',
                       city: cities(:paris),
                       latitude: cities(:paris).latitude,
                       longitude: cities(:paris).longitude,
                       address: '123 Main Street',
                       phone_number: '1234567890',
                       stars: 5.0,
                       rating_count: 1000,
                       image_url: 'http://venue.jpg',
                       yelp_id: 'a-valid-venue'
  end
  
  test "setup creates valid venue" do
    assert @venue.valid?, @venue.errors.inspect
  end
  
  test "venue must have name" do
    @venue.name = nil
    
    assert @venue.invalid?
    assert_match(/can't be blank/, @venue.errors[:name].inspect)
  end
  
  test "venue must belong to a city" do
    @venue.city = nil
    
    assert @venue.invalid?
    assert_match(/can't be blank/, @venue.errors[:city].inspect)
  end
  
  test "venue must have latitude" do
    @venue.latitude = nil
    
    assert @venue.invalid?
    assert_match(/can't be blank/, @venue.errors[:latitude].inspect)
  end
  
  test "venue must have longitude" do
    @venue.longitude = nil
    
    assert @venue.invalid?
    assert_match(/can't be blank/, @venue.errors[:longitude].inspect)
  end
  
  test "venue must have an address" do
    @venue.address = nil
    
    assert @venue.invalid?
    assert_match(/can't be blank/, @venue.errors[:address].inspect)
  end
  
  test "venue must have a phone number" do
    @venue.phone_number = nil
    
    assert @venue.invalid?
    assert_match(/can't be blank/, @venue.errors[:phone_number].inspect)
  end
  
  test "venue must have a star rating" do
    @venue.stars = nil
    
    assert @venue.invalid?
    assert_match(/can't be blank/, @venue.errors[:stars].inspect)
  end
  
  test "venue star rating must be a multiple of 0.5 between 1 and 5" do
    @venue.stars = 0
    
    assert @venue.invalid?
    assert_match(/is not included in the list/, @venue.errors[:stars].inspect)
  end
  
  test "venue must have a rating count" do
    @venue.rating_count = nil
    
    assert @venue.invalid?
    assert_match(/can't be blank/, @venue.errors[:rating_count].inspect)
  end
  
  test "venue must have a yelp id" do
    @venue.yelp_id = nil
    
    assert @venue.invalid?
    assert_match(/can't be blank/, @venue.errors[:yelp_id].inspect)
  end
  
  test "venue yelp id must be unique" do
    venue = Venue.new yelp_id: venues(:cafe).yelp_id
    
    assert venue.invalid?
    assert_match(/has already been taken/, venue.errors[:yelp_id].inspect)
  end
  
  test "venue can't be destroyed if referenced by tour stops" do
    tour_stop = TourStop.new tour: tours(:birthday),
                             venue: @venue
    @venue.save!
    tour_stop.save!
    
    assert_not @venue.destroy
    assert_match(/Tour Stops referencing this venue/, @venue.errors.inspect)
    
    tour_stop.destroy
    assert @venue.destroy
  end
end
