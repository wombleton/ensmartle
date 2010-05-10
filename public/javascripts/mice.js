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
  
  $('#event_data').focus();

  function fetch() {
    var form = $('#new_event');
    $.ajax({
      url: form.attr('action') + '?' + $.param($(this).serializeArray()) + 'since=' + $(document).data('mice-since'),
      type: 'GET',
      dataType: 'json',
      success: function(data) {
        alert(data);
      }
    });
  }

  function poll() {
    $.ajax({
      url: 'http://api.notify.io/v1/listen/daa32ab959b3d0442ba29a1af421c7aa3355513e',
      success: function(data) {
        fetch();
        setTimeout(poll, 10);
      },
      failure: function() {
        setTimeout(poll, 10000);
      },
      async: true,
      cache: false,
      dataType: 'json',
      type: 'GET'
    });
  }

  poll();
});
