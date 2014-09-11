module VenuesHelper
  # Div containing the venue's star rating.
  #
  # This uses icons to visualize the star rating provided by the Yelp API.
  def venue_rating_stars(venue)
    content_tag :div, title: "#{venue.stars} / 5 stars" do
      (1..5).map { |star|
        if venue.stars > star - 1
          if venue.stars < star
            fa_icon 'star-half-o' 
          else
            fa_icon 'star'
          end
        else
          fa_icon 'star-o'
        end
      }.join('').html_safe
    end
  end
  
  # URL for the venue's thumbnail image.
  #
  # This converts URLs provided by the Yelp API into protocol-relative URLs.
  def venue_thumbnail_url(venue)
    venue.image_url.sub(/^https?\:/, '')   
  end
  
  # Div containing the venue's address.
  #
  # This converts the address provided by the Yelp API into a more readable format.
  def venue_address(venue)
    city = venue.city.name
    address = venue.address
    return address unless /#{city}/i =~ address

  end
end
