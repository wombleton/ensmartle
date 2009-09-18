$(document).ready(function() {
  $('#event_data').keypress(function(e) {
    if (e.keyCode == 13) {
      var textarea = $(e.target)[0];
      var form = $(textarea).parent('form')[0];

      $.ajax({
        data: $.param($(form).serializeArray()),
        dataType: 'html',
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
});