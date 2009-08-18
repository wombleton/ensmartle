function poll() {
  $.get('/comet', {}, respond, 'json');
}

function respond(o) {
  poll();
}

$(document).ready(function() {
  $('#dice').click(function(e) {
    var target = $(e.target);
    if (target.is('a.roll')) {
      $.post(target.attr('href'), {
        'by': $('#by')[0].value,
        'latest': $('#latest')[0].value,
        '_method': 'put',
        'authenticity_token': $('#make_roll [name=authenticity_token]')[0].value
      });
    }
    return false;
  });

  $('#new-roll').submit(function() {
    return false;
  });

  $('#rolls').click(function(e) {
    return false;
  });

  $('#new_event').keydown(function(e) {
    var form = e.target;
    if (e.keyCode == 13) {
      $.ajax({data:$.param($(form).serializeArray()) + '&authenticity_token=' + encodeURIComponent($('#new_event input[name=authenticity_token]')[0].value), dataType:'text', type:'post', url: $('#new_event')[0].action});
      $('#new_event textarea')[0].value = '';
      window.location.reload();
      return false;
    }
  });
  $('#new_event textarea').focus();
});
