$ ->
  
  $(window).on 'load', (e) ->
    
    $('#signature_box').length && $('#signature_box').sketch()
  
  $('#signature form').on 'submit', (e) ->
    $('.file', this).attr('value', $('#signature_box')[0].toDataURL())
  
  $('#sign-btn').on 'click', (e) ->
    e.preventDefault()
    w = window.open $(this).attr('href'), 'sig', 'height=400,width=700,toolbar=no'
    w.onunload = ->
      if w.location.origin != 'null'
        console.log 'closed'