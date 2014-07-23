class TourStop < ActiveRecord::Base
  belongs_to :tour
  belongs_to :venue
  
  enum status: { maybe: 0, yes: 1, no: 2 }
end
