json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :city
  json.url venue_url(venue, format: :json)
end
