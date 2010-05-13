(function() {
  function scroll() {
    window.scrollBy(0, 9999999999999);
    $('#event_data').focus();
  }

  $.extend({
    interpolate: function(s, data) {
      return s.replace(/\{(.+?)\}/g, function(m, i) {
        values = $.val(data, i);
        return values === undefined ? '' : values;
      });
    }
  });


  function update(events) {
    $.each(events, function(i, event) {
      $('#log').append($.interpolate('<li id="event-{id}"><div class="user">{user}</div><div class="sheet">{sheet}</div><div>{result}</div></li>', event));
    });
    if (events.length) {
      $(document).data('mice-since', events[events.length - 1]['updated_at']);
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
        setTimeout(poll, 10000);
      }
    });
  }

  $(document).ready(function() {
    scroll();
    
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

