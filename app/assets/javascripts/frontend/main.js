$(document).ready(function(){

	$("#banner-navigation > ul > li > a").click(function() {
		
		if($(this).parent().hasClass('show-sub')){
			$("#banner-navigation > ul > li").removeClass('show-sub');
			$("#banner-navigation").removeClass('active')
		}
		else{
			$("#banner-navigation > ul > li").removeClass('show-sub');
			$("#banner-navigation").addClass('active')
			$(this).parent().addClass('show-sub');
		}

	});

	//MENU ICON
	$(".menu-icon, .menu-exit").click(function(){
	    $("#navigation").toggleClass("show");
	    nav_height_trigger();
	});

	$(window).resize(function() {

	   $("#navigation").removeClass("show");
	   $("#navigation").css({"height": "auto", "min-height":"100%"});

	});

	// init Masonry
	var $grid = $('.gallery').masonry({
	  // options...
	  itemSelector: '.gallery-thumb',
	  percentPosition: true
	});

	// layout Masonry after each image loads
	$grid.imagesLoaded().progress( function() {
	  $grid.masonry();
	});
	  

});