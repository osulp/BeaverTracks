$(document).ready(function() {
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(populate_form, show_form)
  } else {
    $("#geo-form").show();
  }
})

function show_form() {
  $("#geo-form").show();
}

function populate_form(geolocation) {
  $("#patron_lat").val(geolocation.coords.latitude)
  $("#patron_lng").val(geolocation.coords.longitude)
  $("form").submit()
}

