require 'test_helper'

class CityTest < ActiveSupport::TestCase
  
  setup do
    @city = City.new name: 'Valid City',
                     latitude: 55555.55,
                     longitude: -55555.55
  end
  
  test "setup creates valid city" do
    assert @city.valid?, @city.errors.inspect
  end
  
  test "city must have a name" do
    @city.name = nil
    
    assert @city.invalid?
    assert_match(/can't be blank/, @city.errors[:name].inspect)
  end
  
  test "city must have a latitude" do
    @city.latitude = nil
    
    assert @city.invalid?
    assert_match(/can't be blank/, @city.errors[:latitude].inspect)
  end
  
  test "city must have a longitude" do
    @city.longitude = nil
    
    assert @city.invalid?
    assert_match(/can't be blank/, @city.errors[:longitude].inspect)
  end
end
