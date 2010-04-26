$(document).ready(function() {
  $('#event_data').keypress(function(e) {
    if (e.keyCode == 13) {
      var textarea = $(e.target)[0];
      var form = $(textarea).parent('form')[0];

      $.ajax({
        data: $.param($(form).serializeArray()),
        dataType: 'html',
        success: function() {
          window.location.reload();
        },
        type: form.method,
        url: form.action
      });
      textarea.value = '';
      return false;
    }
  });

  $('#characters').click(function(e) {
    var target = $(e.target)[0];
    var form = $(target).closest('form')[0];
    if ($(target).is('input[type=radio]')) {
      $.ajax({
        data: $.param($(form).serializeArray()),
        type: form.method,
        url: form.action
      });
    }
  });

  $('#tabs').tabs();
  
  $('#event_data').focus();

  function poll() {
    $.ajax({
      url: 'http://api.notify.io/v1/listen/daa32ab959b3d0442ba29a1af421c7aa3355513e',
      success: function(data) {
        setTimeout(poll, 10);
      },
      failure: function() {
        setTimeout(poll, 10);
      },
      timeout: 30000,
      async: true,
      cache: false,
      dataType: 'json',
      type: 'GET'
    });
  }

  poll();
});
