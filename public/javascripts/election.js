var MELEE = {};

MELEE.Election = function() {
	var delay = 15;
	var pollCount = 0;
	
	function appendTweets(){
		var tweets = $$('#tweetBucket .hentry');
		if (tweets.length > 0) {
			var tweet = tweets[tweets.length - 1];
			tweet.setStyle({
				display: 'none'
			});
			$('twitter').insert({
				top: tweet
			});
			new Effect.Appear(tweet);
			setTimeout(appendTweets, 2 * 1000);
		} else {
			setTimeout(getTweets, delay * 1000);
		}
	}
	
	function getTweets(){
		pollCount++;
		if (pollCount > 15) {
			window.location = 'http://election.melee.net.nz/08';
		} else {
			var first_tweet = $$('#twitter .hentry').first();
			var since = first_tweet ? Number(/status_(\d+)/.exec(first_tweet.id)[1]) : 0;
			$('status-img').show();
			new Ajax.Request('/08', {
				method: 'GET',
				parameters: {
					since: since
				},
				onComplete: function(o){
					$('status-img').hide();
					if ($('tweets')) {
						$('tweets').remove();
					}
					Element.insert(document.body, {
						bottom: '<table id="tweets" style="display:none"><tbody id="tweetBucket"></tbody></table>'
					});
					if (o.responseText.match(/\w/)) {
						Element.update('tweetBucket', o.responseText);
					}
					appendTweets();
					updateDates();
				}
			});
			
		}
	}
	
	function updateDates() {
		var dates = $$('#twitter .hentry .content .entry-date span');
		var now = new Date();
		for (var i = 0; i < dates.length; i++) {
			var d = dates[i];
			d.update(relativeTime(new Date(d.readAttribute('title')), now));
		}
	}
	
	function relativeTime(A, B){
		var C = (B.getTime() - A.getTime()) / 1000;
		if (C < 5) {
			return "less than 5 seconds"
		} else if (C < 10) {
			return "less than 10 seconds";
		} else if (C < 20) {
			return "less than 20 seconds";
		} else if (C < 60) {
			return "less than a minute";
		} else if (C < 120) {
			return "about a minute";
		} else if (C < (60 * 60)) {
			return Math.round(C / 60) + " minutes";
		} else if (C < (120 * 60)) {
			return "about an hour";
		} else if (C < (24 * 60 * 60)) {
			return "about " + Math.round(C / 3600) + " hours";
		} else if (C < (48 * 60 * 60)) {
			return "1 day";
		} else {
			return Math.round(C / 86400) + " days";
		}
	}
	
	function update(e) {
		Event.stop(e);
		new Ajax.Request('http://twitter.com/statuses/update.json', {
			method: 'POST',
			parameters: {
				status: $('thinking').value,
				in_reply_to_status_id: $('in_reply_to_status_id').value
			}
		});
	}
	
	Event.observe(window, 'load', function(){
		setTimeout(getTweets, 15 * 1000);
	});
	
	return {}
}();

