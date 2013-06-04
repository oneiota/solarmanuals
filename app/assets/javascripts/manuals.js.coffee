$ ->
  
  $(window).scrollTop(0)
  
  opts =
    lines: 9 # The number of lines to draw
    length: 7 # The length of each line
    width: 4 # The line thickness
    radius: 6 # The radius of the inner circle
    corners: 1 # Corner roundness (0..1)
    rotate: 0 # The rotation offset
    color: '#000' # #rgb or #rrggbb
    speed: 1.5 # Rounds per second
    trail: 49 # Afterglow percentage
    shadow: false # Whether to render a shadow
    hwaccel: true # Whether to use hardware acceleration
    className: 'spinner' # The CSS class to assign to the spinner
    zIndex: 2e9 # The z-index (defaults to 2000000000)
    top: 'auto' # Top position relative to parent in px
    left: 'auto' # Left position relative to parent in px
  
  
  
  $("#submit-subscription").on "click", (e) ->
    e.preventDefault()
    $(this).closest("form").submit()
    $("#subscription-loading").show()
    
  if $('html').hasClass('shit')
    $("#upload-pdfs-btn").hide()
  else
    $('#upload-pdf-fields').hide()
  
    $('#upload-pdfs-btn').on 'click', (e) ->
      e.preventDefault()
      $('.upload-pdfs-input').trigger 'click'
    
    $('.upload-pdfs-input').on 'change', ->
      if this.files
        # check file extensions are .pdf
        for f in this.files
          if f.name.split('.').pop() != 'pdf'
            return alert('Please choose PDF files')
        
      $('#upload-pdfs-btn').text('Uploading...')
      $('body').addClass('submitting')
      $('.upload-pdfs-form').submit()
  
  # show/hide checkboxes
  $('.showhide input[type=checkbox]:not(:checked)').each ->
    $(this).closest('.showhide').children('.fields').hide()
  $('.showhide input[type=checkbox]').on 'change', ->
    fields = $(this).closest('.showhide').children('.fields')
    if $(this).is(':checked')
      fields.show()
    else
      fields.hide()
  
  do visibleRemoveButtons = ->
    fields = $('.remove_fields')
    fields.show()
    if $('.remove_fields:visible').length == 1
      fields.hide()
  
  # http://railscasts.com/episodes/196-nested-model-form-revised?view=asciicast  
  $('form').on 'click', '.add_fields', (event) ->
    id = $('.string-fields').length
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).parent().before($(this).data('fields').replace(regexp, id))
    event.preventDefault()
    visibleRemoveButtons()
    
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('li').slideUp ->
      visibleRemoveButtons()
    event.preventDefault()
    
  
  $('[data-serial-range]').each ->
    self = this
    $('.serial-range input', self).on 'keydown', (e) ->
      if e.which == 13
        e.preventDefault()
        from = parseInt($('.range-from', self).val())
        to = parseInt($('.range-to', self).val())
        if from && to
          serials = [from..to]
          existing = $('[data-serial-range-output]', self).val() || ""
          existingArray = _.map existing.split(","), (s) ->
            s.replace(/\ /g,'')
          result = _.reject existingArray.concat(serials), (s) ->
            !s
          $('[data-serial-range-output]', self).val(result.join(', '))
          $('.range-from, .range-to', self).val('')
  
  $('.field.checklist').each ->
    console.log(this)
    self = this
    do checkNA = ->
      na = $('.na-field', self).val() == 'true'
      $(self).toggleClass('na', na)
      $('.na-btn', self).text(if na then 'Undo' else 'N/A')
    $('.na-btn', self).on 'click', (e) ->
      e.preventDefault()
      newVal = if $('.na-field', self).val() == 'true' then 'false' else 'true'
      $('.na-field', self).val(newVal)
      checkNA()