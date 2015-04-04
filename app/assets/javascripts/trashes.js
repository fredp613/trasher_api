
  $(window).scroll(function() {
  	var url = $('.pagination .next_page').attr('href')  	
  	if (url && ($(window).scrollTop() > ($(document).height() - $(window).height()) - 50)) {  		
  		$('.pagination').text("fetching more trash...")
  		$.getScript(url)
  	}
  })
