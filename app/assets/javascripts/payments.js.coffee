toggleCreditCard = ->
  $(".show-cc-fields").toggle()
  $('.subscribe-now').toggle()
  $("#subscribe-cc-fields").toggle()
  $('.hide-cc-fields').toggle()
  

$ ->
  $(".show-cc-fields").on 'click', (e) ->
    toggleCreditCard()
    e.preventDefault()
  
  $('.hide-cc-fields').hide().on 'click', (e) ->
    toggleCreditCard()
    e.preventDefault()    