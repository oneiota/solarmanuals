$ ->
  
  $(".home.index #home-menu a.scroll").on 'click', (e) ->
    e.preventDefault()
    scrltarget = $(this).attr('href').substr(1)
    $("html, body").animate { scrollTop: $(scrltarget).offset().top - 200 }, 'slow', (e) ->
      $('#device').css('height', '0px')

  $(".home.index #home-menu #logo a").on 'click', (e) ->
    e.preventDefault()
    if $(document).width() > 768
      $("html, body").animate
        scrollTop: 0
        , 1000
    else
      $('#home-menu ul').toggle(500);
      $('#logo').toggleClass('open');

  $(".get_started").on 'click', (e) ->
    if $(document).width() < 480
      e.preventDefault()
      alert('We are sorry but our website is not optimised for mobile use. Please visit us again on a non-mobile device to try our service for free.')
         