require 'test_helper'

class TourStopTest < ActiveSupport::TestCase
  
  setup do
    @tour_stop = TourStop.new tour: tours(:newyear),
                              venue: venues(:cafe)
  end
  
  test "setup creates valid tour stop" do
    assert @tour_stop.valid?, @tour_stop.errors.inspect
  end
  
  test "tour stop must belong to a tour" do
    @tour_stop.tour = nil
    
    assert @tour_stop.invalid?
    assert_match(/can't be blank/, @tour_stop.errors[:tour].inspect)
  end
  
  test "tour stop must have a venue" do
    @tour_stop.venue = nil
    
    assert @tour_stop.invalid?
    assert_match(/can't be blank/, @tour_stop.errors[:venue].inspect)
  end
  
  test "tour stop default status is maybe" do
    assert_match(/maybe/, @tour_stop.status)
  end
end
