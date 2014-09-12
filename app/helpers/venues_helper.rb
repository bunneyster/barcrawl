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
  
  # Data attributes for the link targeted by the venue dropdown.
  def venue_name_data(venue)
    { dropdown: "venue-#{venue.to_param}",
      options: "is_hover:true;align:top" }    
  end
  
  def venue_dropdown(venue)
    content_tag :div, id: "venue-#{venue.to_param}", class: "small f-dropdown", data: {dropdown_content: ''} do
      image_tag venue_thumbnail_url(venue)
      content_tag :div, class: "avatar-label" do
        venue_rating_stars(venue) + tag(:br) + 
        content_tag(:div, "out of #{venue.rating_count} ratings", class: "note") + tag(:br) +
        venue.address
      end
    end
  end
end
