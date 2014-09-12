module TourStopsHelper
  def tour_stop_li_class(tour_stop)
    if tour_stop.upvoted_by(@current_user)
      'tour-stop-upvoted'
    elsif tour_stop.downvoted_by(@current_user)
      'tour-stop-downvoted'
    else
      'tour-stop-notvoted'
    end
  end
  
  def tour_stop_li_data(tour_stop)
    { venue_name: tour_stop.venue.name,
      venue_lat: tour_stop.venue.latitude,
      venue_lng: tour_stop.venue.longitude }
  end
end
