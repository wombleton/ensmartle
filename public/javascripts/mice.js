(function() {
  var force = true;
  function scroll() {
    if (force || window.innerHeight + window.pageYOffset + $('#log li:last').height() >= document.body.offsetHeight) {
      force = false;
      window.scrollBy(0, document.body.offsetHeight);
      $('#event_data').focus();
    }
  }

  $.extend({
    interpolate: function(s, data) {
      return s.replace(/\{(.+?)\}/g, function(m, i) {
        return data[i] === undefined || data[i] === null ? '' : data[i];
      });
    }
  });

  $('li.help a').qtip({
    content: 'test',
    show: 'mouseover',
    hide: 'mouseout'
  });

  function update(events) {
    $.each(events, function(i, event) {
      $('#log').append($.interpolate('<li id="event-{id}"><div class="user">{user}</div><div class="sheet">{sheet}</div>{result}</li>', event));
    });
    if (events.length) {
      $(document).data('mice-since', events[events.length - 1]['updated_at']);
      scroll();
    }
  }

function fetch() {
    var form = $('#new_event');
    $.ajax({
      url: $.interpolate('{url}?{params}&since={since}', {
        url: form.attr('action'),
        params: $.param($(this).serializeArray()),
        since: $(document).data('mice-since') || ''
      }),
      type: 'GET',
      dataType: 'json',
      success: function(data) {
        update(data);
        setTimeout(fetch, 3000);
      },
      failure: function() {
        setTimeout(fetch, 15000);
      }
    });
  }

  $(document).ready(function() {
    $('#new_event').submit(function() {
      $.ajax({
        data: $.param($(this).serializeArray()),
        dataType: 'json',
        success: function() {
          window.location.reload();
        },
        type: 'POST',
        url: $(this).attr('action')
      });
      $('input', this).val('');
      return false;
    });
    fetch();
  });

})();

