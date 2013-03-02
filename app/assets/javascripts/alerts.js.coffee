$ ->
  x = $("<i class='icon-remove'>")
  $('.alert').append(x).on 'click', ->
    $(this).slideUp(200)