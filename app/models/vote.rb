class Vote < ActiveRecord::Base
  belongs_to :voter, class_name: :User
  validates :voter, presence: true
  
  belongs_to :tour_stop
  validates :tour_stop, presence: true
  
  validates :score, inclusion: { in: [1, -1] }
end
