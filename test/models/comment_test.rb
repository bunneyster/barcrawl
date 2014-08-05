require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  setup do
    @comment = Comment.new commenter: users(:peridot),
                           tour_stop: tour_stops(:first),
                           text: "I am a valid comment.",
                           created_at: Time.now
  end
  
  test "setup creates valid comment" do
    assert @comment.valid?, @comment.errors.inspect
  end
  
  test "comment must have commenter" do
    @comment.commenter = nil
    
    assert @comment.invalid?
    assert_match(/can't be blank/, @comment.errors[:commenter].inspect)
  end
  
  test "comment must have tour stop" do
    @comment.tour_stop = nil
    
    assert @comment.invalid?
    assert_match(/can't be blank/, @comment.errors[:tour_stop].inspect)
  end
  
  test "comment must have text" do
    @comment.text = nil

    assert @comment.invalid?
    assert_match(/can't be blank/, @comment.errors[:text].inspect)
  end
  
  test "comment text must have more than 1 character" do
    @comment.text = ""
    assert @comment.invalid?
    assert_match(/is too short/, @comment.errors[:text].inspect)
  end
  
  test "comment text must not have more than 300 characters" do
    @comment.text = "party" * 61
    assert @comment.invalid?
    assert_match(/is too long/, @comment.errors[:text].inspect)
  end
end
