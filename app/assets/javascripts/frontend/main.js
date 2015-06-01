$(document).ready(function(){

	$(".banner-nav-link").click(function() {
		
		if($(this).parent().hasClass('show-sub')){
			$(".banner-nav-link").parent().removeClass('show-sub');
			$("#banner-navigation").removeClass('active')
		}
		else{
			$(".banner-nav-link").parent().removeClass('show-sub');
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

});