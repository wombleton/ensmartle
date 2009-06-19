var MICE = function() {
  function poll(roll) {
      $('#roll').value = roll || '';
      $('#latest').value = ($('#rolls .roll').first() || document.body).attr('updated_at');
      var form = $('#make_roll');
      $.ajax({
        type: "POST",
        url: form.action,
        data: "name=John&location=Boston",
        success: function(msg){
        alert( "Data Saved: " + msg );
        }
      });

      new Ajax.Request(form.action, {
        parameters: Form.serialize(form),
        onComplete: function(o) {
          $('#rolls').insert({
            top: o.responseText
          });
          var ids = {};
          $('#rolls .roll').each(function(r){
            var id = r.readAttribute('roll_id');
            if (ids[id]) {
              r.remove();
            }
            ids[id] = r;
          });
        }
      });
    };
}();

$(document).ready(function() {


});


  Event.observe(window, 'load', function() {
    Event.observe('dice', 'click', function(e) {
      Event.stop(e);
      poll(Event.findElement(e, 'a').innerHTML);
    });

    Event.observe('rolls', 'click', function(e) {
      var target = Event.findElement(e, 'a');
      if (target) {
        Event.stop(e);
        $('explode').value = target.readAttribute('roll_id');
        var form = $('explode_form');
        var li = Event.findElement(e, 'li');
        new Ajax.Request(form.action, {
          parameters: Form.serialize(form),
          onSuccess: function(o) {
            li.replace(o.responseText);
          }
        });
      }

    });
    new PeriodicalExecuter(function() {poll('')}, 10);
  });