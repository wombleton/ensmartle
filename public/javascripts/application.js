(function(){
    var tips = {};
    
    function showTooltip(target){
        if (!$('tt')) {
            Element.insert(document.body, {
                bottom: '<table id="tt"><tr><td class="tl"><td class="t"><td class="tr"><tr><td class="l"><td id="tt-bd">omg hi2u</td><td class="r"><tr><td class="bl"><td class="b"><td class="br"><tr><td><td class="tip"><td></table>'
            });
        }
        var tt = $('tt');

        var href = target.down('a').href;
        var id = href.substring(href.lastIndexOf('/') + 1);
        var tooltip = tips[id] || 'Loading ...';
        $('tt-bd').update(tooltip);
        if (!tips[id]) {
            new Ajax.Request('/spells/' + id + '/tooltip', {
                method: 'get',
                onComplete: function(o){
                    var text = o.responseText || "No tooltip data!";
                    $('tt-bd').update(text);
                    position(tt, target);
                    if (o.responseText) {
                        tips[id] = o.responseText;
                    }
                }
            });
        }
        position(tt, target);
        tt.show();
    }

    function position(tt, target) {
        var height = tt.getHeight();
        var position = Element.cumulativeOffset(target);
        tt.setStyle({
            position: 'absolute',
            top: (position[1] - (height + 0)) + 'px',
            left: position[0] + 'px'
        });
    }

    var showTimeout = null;
    var hideTimeout = null;
/*
    Event.observe(document, 'mouseover', function(e) {
        var target = Event.findElement(e, 'li');
        if (target && target.match('li.recipe')) {
            if (showTimeout) {
                clearTimeout(showTimeout);
            }
            showTimeout = setTimeout(function() {
                showTooltip(target);
            }, 200);
        }
    });

    Event.observe(document, 'mouseout', function(e) {
        clearTimeout(hideTimeout);
        hideTimeout = setTimeout(function() {
            if ($('tt')) {
                $('tt').hide();
            }
        }, 100);
    });
*/
    Event.observe(window, 'load', function() {
      $('q').activate();
    });
})();

