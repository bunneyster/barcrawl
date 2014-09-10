function onGoogleMapsLoad() {
  var mapElement = document.getElementById('tour-stops-map');
  if (!mapElement)
    return;
  
  var cityLat = document.getElementById('description').getAttribute("data-tour-city-lat");
  var cityLng = document.getElementById('description').getAttribute("data-tour-city-lng");
    
  var mapOptions = {
    zoom: 12,
    center: new google.maps.LatLng(cityLat, cityLng)
  };

  var map = new google.maps.Map(document.getElementById('tour-stops-map'), mapOptions);
  var bounds = new google.maps.LatLngBounds();

  var pinIcons = {};
  var states =  ['proposed', 'accepted', 'rejected'];
  for (var i = 0; i < states.length; ++i) {
    state = states[i];
    pinIcons[state] = new google.maps.MarkerImage(
                        ImagePaths[state + "VenuePin"],
                        new google.maps.Size(21, 34),
                        new google.maps.Point(0,0),
                        new google.maps.Point(10, 34));
  }
  
  var proposedVenuesList = document.querySelector('section#proposed ol').querySelectorAll('li');
  var acceptedVenuesList = document.querySelector('section#accepted ol').querySelectorAll('li');
  var rejectedVenuesList = document.querySelector('section#rejected ol').querySelectorAll('li');
  
  for (var li = 0; li < proposedVenuesList.length; li++) {
    var venue = proposedVenuesList[li];
    var venueName = venue.getAttribute("data-venue-name");
    var venueLat = venue.getAttribute("data-venue-lat");
    var venueLng = venue.getAttribute("data-venue-lng");
    var venuePos = new google.maps.LatLng(venueLat, venueLng);
    
    var marker = new google.maps.Marker({
      position: venuePos,
      map: map,
      title: venueName,
      icon: pinIcons.proposed,
      opacity: 0.8
    });
        
    bounds.extend(venuePos);
    map.fitBounds(bounds);
  }
  
  for (var li = 0; li < acceptedVenuesList.length; li++) {
    var venue = acceptedVenuesList[li];
    var venueName = venue.getAttribute("data-venue-name");
    var venueLat = venue.getAttribute("data-venue-lat");
    var venueLng = venue.getAttribute("data-venue-lng");
    var venuePos = new google.maps.LatLng(venueLat, venueLng);
    
    var marker = new google.maps.Marker({
      position: venuePos,
      map: map,
      title: venueName,
      icon: pinIcons.accepted,
      opacity: 0.8
    });
            
    bounds.extend(venuePos);
    map.fitBounds(bounds);
  }
  
  for (var li = 0; li < rejectedVenuesList.length; li++) {
    var venue = rejectedVenuesList[li];
    var venueName = venue.getAttribute("data-venue-name");
    var venueLat = venue.getAttribute("data-venue-lat");
    var venueLng = venue.getAttribute("data-venue-lng");
    var venuePos = new google.maps.LatLng(venueLat, venueLng);
    
    var marker = new google.maps.Marker({
      position: venuePos,
      map: map,
      title: venueName,
      icon: pinIcons.rejected,
      opacity: 0.8
    });
        
    bounds.extend(venuePos);
    map.fitBounds(bounds);
  }
}
