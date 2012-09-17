/******************************
* Patrick Dura
* ifeelfb
* Creation : 17/09/2012
* Update : 17/09/2012
*******************************/

/// Depends on :
///   Jquery 1.7.1

// Namespace
var App = {
    version:"0.0.1"
};

// Init Space
App.components={};

// Init when dom ready
$(document).ready(function() {
    
    App.Init();

});

App.Init = function(){
	
	FB.init({
        appId: '436982539681428',//"<%= Facebook.config[:client_id] %>",
        cookie: true,
        xfbml: true,
        oauth: true
      });

}
