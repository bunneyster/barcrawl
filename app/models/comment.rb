class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: User
  validates :commenter, presence: true
  
  belongs_to :tour_stop
  validates :tour_stop, presence: true
  
  validates :text, presence: true, length: 1..300

end
