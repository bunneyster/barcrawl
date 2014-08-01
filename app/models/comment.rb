class Comment < ActiveRecord::Base
  belongs_to :commenter
  belongs_to :tour_stop
end
