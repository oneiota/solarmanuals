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
  
  
  # payments graph
  amounts = []
  $months = $('#invoice-graph .month')
  $months.each ->
    amounts.push parseInt($(this).data('count')) || 0
  max = amounts.reduce (a,b) -> Math.max a, b
  $months.each (i) ->
    maxHeight = 100
    height = amounts[i] / maxHeight + 2
    $(this).append($('<i>').css('height', height))
  
  $('.month').on 'click', (e) ->
    e.preventDefault()
    month = $(this).data('month')
    $('.invoices-list').hide()
    $('[data-month]').removeClass('current')
    $("[data-month=#{month}]").addClass('current')
    $list = $(".invoices-list[data-month=#{month}]").show()
    $('#invoices').css('min-height', $list.height())