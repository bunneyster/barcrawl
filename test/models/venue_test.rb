require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  
  setup do
    @venue = Venue.new name: 'A Valid Venue',
                       city: cities(:paris),
                       cid: 1234567890,
                       latitude: cities(:paris).latitude,
                       longitude: cities(:paris).longitude
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
  
  test "venue must have cid" do
    @venue.cid = nil
    
    assert @venue.invalid?
    assert_match(/can't be blank/, @venue.errors[:cid].inspect)
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
  
  test "venue name must be unique" do
    venue = Venue.new name: venues(:cafe).name
    
    assert venue.invalid?
    assert_match(/has already been taken/, venue.errors[:name].inspect)
  end
  
  test "venue cid must be unique" do
    venue = Venue.new cid: venues(:cafe).cid
    
    assert venue.invalid?
    assert_match(/has already been taken/, venue.errors[:cid].inspect)
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
