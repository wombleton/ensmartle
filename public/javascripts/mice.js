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

  function update(events) {
    var username = $('span.user').html().trim();
    $.each(events, function(i, event) {
      var roll = event.event_type === 'roll',
          template;
      if (roll) {
        template = '<li id="event-{id}" class="{event_type}"><div class="user">{user}</div><div class="sheet">{sheet}</div>[Roll] {result}</li>';
      } else {
        template = '<li id="event-{id}" class="{event_type}"><div class="user">{user}</div><div class="sheet">{sheet}</div>{result}</li>';
      }
      $('#log').append($.interpolate(template, event));
      if (event.event_type === 'setname' && event.user === username) {
        $('.character').html(event.sheet);
      }
    });
    if (events.length) {
      $(document).data('mice-since', events[events.length - 1]['updated_at']);
      scroll();
    }
  }

function fetch() {
    var form = $('#new_event');
    $.ajax({
      url: $.interpolate('{url}?since={since}', {
        url: form.attr('action'),
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

    $('li.help a').tooltip({
      delay: 300,
      offset: [-0, -50],
      position: 'top right',
      tip: '#help',
      effect: 'fade'
    }).click(function() {return false;});
  });


})();

