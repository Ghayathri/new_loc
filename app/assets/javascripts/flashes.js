// Method for fading out bootstrap alert
$(document).ready(function() {
  $(window).bind('rails:flash', function(e, params) {
  	if (params.type == "notice"){
	    new PNotify({
	      text: params.message,
	      type: params.type,
	      icon: null
	    });
	  }
	  else if (params.type == "error"){
	  	new PNotify({
	      text: params.message,
	      type: params.type,
	      icon: null
	    });
	  }
	  else if (params.type == "success"){
	  	new PNotify({
	      text: params.message,
	      type: params.type,
	      icon: null
	    });
	  }
	  else if (params.type == "alert"){
	    new PNotify({
	      text: params.message,
	      type: params.type,
	      icon: null
	    });
	  }
  });
});