function initialize() {

  var options = {
    types: ['(cities)']
    , componentRestrictions: {country: "ir"}
  };

  var origin = document.getElementById('location_city');
  var autocomplete_origin = new google.maps.places.Autocomplete(origin, options);
  google.maps.event.addListener(autocomplete_origin, 'place_changed', function () {
    var place = autocomplete_origin.getPlace();
    document.getElementById('search_subtrip_olat').value    = place.geometry.location.lat();
    document.getElementById('search_subtrip_olng').value    = place.geometry.location.lng();
   });

}
google.maps.event.addDomListener(window, 'load', initialize);