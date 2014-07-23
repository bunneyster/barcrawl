json.array!(@tours) do |tour|
  json.extract! tour, :id, :name, :organizer, :starting_at, :image, :description
  json.url tour_url(tour, format: :json)
end
