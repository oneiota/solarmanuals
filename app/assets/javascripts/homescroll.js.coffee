$ ->
  
  $(".home.index #home-menu a.scroll").on 'click', (e) ->
    e.preventDefault()
    scrltarget = $(this).attr('href').substr(1)
    $("html, body").animate { scrollTop: $(scrltarget).offset().top - 200 }, 'slow', (e) ->
		  console.log("done")
		  $('#device').css('height', '0px')
		  
	$(".home.index #home-menu #logo a").on 'click', (e) ->
	 e.preventDefault()
	 $("html, body").animate { scrollTop: 0 }, 1000
    