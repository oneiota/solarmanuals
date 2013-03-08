toggleCreditCard = ->
  $(".show-cc-fields").toggle()
  $('.subscribe-now').toggle()
  $("#subscribe-cc-fields").toggle()
  $('.hide-cc-fields').toggle()
  

$ ->
  $(".show-cc-fields").on 'click', (e) ->
    $('[name=new_card]').val('1')
    toggleCreditCard()
    e.preventDefault()
  
  $('.hide-cc-fields').hide().on 'click', (e) ->
    $('[name=new_card]').val('0')
    toggleCreditCard()
    e.preventDefault()    