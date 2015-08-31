$(document).ready(function(){
	
	function startBannerNav() {

		if($("#banner-navigation > ul > li").hasClass("selected")){
			//alert('was triggered');
		}else {
			$("#banner-navigation #coffee_event").addClass('show-sub');
			$("#banner-navigation").addClass('active');
		}
	}

	startBannerNav();

	function checkBannerNav() {
		var mWidth = $('body').width();

	   	if (mWidth < 749) {
			$("#banner-navigation > ul > li").removeClass('show-sub');
			$("#banner-navigation").removeClass('active');
		}
	}

	checkBannerNav();

	$("#banner-navigation > ul > li > a").click(function() {
		if($(this).parent().hasClass('show-sub')){
			$("#banner-navigation > ul > li").removeClass('show-sub');
			$("#banner-navigation").removeClass('active');
		}
		else{
			$("#banner-navigation > ul > li").removeClass('show-sub');
			$("#banner-navigation").addClass('active');
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

	   	checkBannerNav();
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
	 

	// instagram
	$('.instagram-caffaasia').instagramLite({
		username: 'caffaasia',
		clientID: '199554eb34504658a4770d2859b5a583',
		urls: true,
		limit: 16,
		load_more: '.instagram-load-more',
		success: function() {			
		},
		error: function(errorCode, errorMessage) {
			console.log('There was an error showing the instagram feed..');
			if(errorCode && errorMessage) {
				alert(errorCode +': '+ errorMessage);
		
			}
		
		}
	});
	var $gridInstagram = $('.instagram-caffaasia').masonry({
	  // options...
	  itemSelector: '.il-item',
	  percentPosition: true
	});

	// layout Masonry after each image loads
	$gridInstagram.imagesLoaded().progress( function() {
	  $gridInstagram.masonry();
	});

});