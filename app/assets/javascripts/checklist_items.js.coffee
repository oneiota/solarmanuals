# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('.checklist-subcontainer').hide()

$('.include-checklist:checkbox').live 'change', ->
	if $(this).is(':checked')
		$('.checklist-subcontainer').show(400)
	else
		$('.checklist-subcontainer').hide(400)