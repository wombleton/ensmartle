function poll() {
  $.get('/comet', {}, respond, 'json');
}

function respond(o) {
  poll();
}

function reload() {
  window.location.reload();
}

$(document).ready(function() {
  $('#event_data').focus();
});
