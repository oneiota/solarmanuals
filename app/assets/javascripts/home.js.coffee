$ ->
  $("body.home .navbar a.scroll").on 'click', (e) ->
    e.preventDefault()
    scrltarget = $(this).attr('href').substr(1)
    $("html, body").animate { scrollTop: $(scrltarget).offset().top - 100 }, 'slow', (e) ->
		  console.log("done")
		  #$('#device').css('height', '0px')
		  
	$("body.home .brand").on 'click', (e) ->
    e.preventDefault()
    $("html, body").animate { scrollTop: 0 }, 1000