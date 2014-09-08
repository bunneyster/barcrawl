function onGoogleMapsLoad() {
  var mapElement = document.getElementById('proposals-map');
  if (!mapElement)
    return;
  
  var cityLat = document.getElementById('description').getAttribute("data-tour-city-lat");
  var cityLng = document.getElementById('description').getAttribute("data-tour-city-lng");
    
  var mapOptions = {
    zoom: 12,
    center: new google.maps.LatLng(cityLat, cityLng)
  };

  var map = new google.maps.Map(document.getElementById('proposals-map'), mapOptions);

  var colors = {
    red: "ff0040",
    green: "a1ff00",
    black: "35007a"
  };
  
  var pinIcons = {};  
  for (var color in colors) {
    if (colors.hasOwnProperty(color)) {
      code = colors[color];
      pinIcons[color] = new google.maps.MarkerImage("//chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + code,
                          new google.maps.Size(21, 34),
                          new google.maps.Point(0,0),
                          new google.maps.Point(10, 34));
    }
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
      icon: pinIcons.red,
      opacity: 0.8
    });
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
      icon: pinIcons.green,
      opacity: 0.8
    });
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
      icon: pinIcons.black,
      opacity: 0.8
    });
  }
}
