require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  
  setup do
    @vote = Vote.new voter: users(:peridot),
                     tour_stop: tour_stops(:cafe_on_birthday),
                     score: 1
  end
  
  test "setup creates valid vote" do
    assert @vote.valid?, @vote.errors.inspect
  end
  
  test "vote must belong to a voter" do
    @vote.voter = nil
    
    assert @vote.invalid?
    assert_match(/can't be blank/, @vote.errors[:voter].inspect)
  end
  
  test "vote must belong to a tour stop" do
    @vote.tour_stop = nil
    
    assert @vote.invalid?
    assert_match(/can't be blank/, @vote.errors[:tour_stop].inspect)
  end
  
  test "vote must have a score" do
    @vote.score = nil
    
    assert @vote.invalid?
    assert_match(/is not included in the list/, @vote.errors[:score].inspect)
  end
  
  test "vote score must be 1 or -1" do
    @vote.score = -1
    assert @vote.valid?
    
    @vote.score = 2
    assert @vote.invalid?
    assert_match(/is not included in the list/, @vote.errors[:score].inspect)
  end
end
