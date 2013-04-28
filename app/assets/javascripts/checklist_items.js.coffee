# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  
  if $(".include-checklist:checkbox").length
    if $(".include-checklist:checkbox").is(":checked")
      $('.checklist-subcontainer').show()
    else
      $('.checklist-subcontainer').hide()

  $('.include-checklist:checkbox').live 'change', ->
    if $(this).is(':checked')
      $('.checklist-subcontainer').show(400)
    else
      $('.checklist-subcontainer').hide(400)
  
  $('[type=checkbox]').each ->
    field = $(this).closest('.field')
    field.addClass('checkbox')
    if this.checked
      field.addClass('checked')
  
  $('[type=checkbox]').on 'change', ->
    $(this).closest('.field').toggleClass('checked', this.checked)
    $(this).toggleClass('checked', this.checked)