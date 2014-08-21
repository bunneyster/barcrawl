module VenuesHelper
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
end
