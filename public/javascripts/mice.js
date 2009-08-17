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
});
