class VenueSearch
  include ActiveModel::Model
  
  attr_accessor :query
  attr_accessor :tour
  
  def tour_id
    tour && tour.id
  end
  def tour_id=(new_tour_id)
    self.tour = new_tour_id && Tour.where(id: new_tour_id).first
  end
  
  def results
    Venue.unproposed_for(tour).where(['name LIKE ?', "%#{query}%"])
  end
  
end