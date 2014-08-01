require 'test_helper'

class TourTest < ActiveSupport::TestCase
  fixtures :users, :tours, :cities, :invitations
  
  setup do
    @tour = Tour.new name: 'Valid Tour',
                     organizer: users(:peridot),
                     city: cities(:paris),
                     starting_at: 1.week.from_now,
                     image: 'tour.jpg',
                     description: 'Cool beans.'
  end
  
  test "setup creates valid tour" do
    assert @tour.valid?, @tour.errors.inspect
  end
  
  test "tour must have a name" do
    @tour.name = nil
    
    assert @tour.invalid?
    assert_match(/can't be blank/, @tour.errors[:name].inspect)
  end
  
  test "tour must have an organizer" do
    @tour.organizer = nil
    
    assert @tour.invalid?
    assert_match(/can't be blank/, @tour.errors[:organizer].inspect)
  end
  
  test "tour must have a city" do
    @tour.city = nil
    
    assert @tour.invalid?
    assert_match(/can't be blank/, @tour.errors[:city].inspect)
  end
  
  test "tour must have a starting time" do
    @tour.starting_at = nil
    
    assert @tour.invalid?
    assert_match(/can't be blank/, @tour.errors[:starting_at].inspect)
  end
  
  test "starting time must be in the future" do
    last_month = 1.month.ago
    @tour.starting_at = last_month
    
    assert @tour.invalid?
    assert_match(/must be on or after/, @tour.errors[:starting_at].inspect)
  end
  
  # test "primary key is a random base64 string"
  
  test "organizer must be invited to tour" do
    assert_equal 0, @tour.users.count
    @tour.save!
    assert_equal 1, @tour.users.count
    assert_equal users(:peridot), @tour.users.first!
  end
end
