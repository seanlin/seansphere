WebFontConfig = {
    google: { families: [ 'Open+Sans:300,400,600,700:latin','Droid+Sans:400,700:latin' ] },
	typekit: { id: 'qgj2ipn'}
  };
  (function() {
    var wf = document.createElement('script');
    wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
      '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
    wf.type = 'text/javascript';
    wf.async = 'true';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(wf, s);
  })();


Hyphenator.config({
	useCSS3hyphenation: true,
	minwordlength : 6,
	selectorfunction: function() {
		return $('p').get();
	}
});
Hyphenator.run();


$(function(){
	$('#tweets').tweetable({username: 'geeksean', time: true, limit: 1, replies: false, position: 'append'});
});
