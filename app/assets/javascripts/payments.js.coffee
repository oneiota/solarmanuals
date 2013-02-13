$ ->
  $("#show-cc-fields").on 'click', (e) ->
    e.preventDefault()
    $(this).hide()
    $("#subscribe-cc-fields").show()