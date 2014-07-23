json.array!(@tour_stops) do |tour_stop|
  json.extract! tour_stop, :id, :tour_id, :venue_id
  json.url tour_stop_url(tour_stop, format: :json)
end
