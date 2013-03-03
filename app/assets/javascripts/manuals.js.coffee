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
  
  prefillFields = (id, type) ->
    $.ajax
      url: '/manuals/'+id
      dataType: 'json'
      data: 
        type: type
      success: (data) ->
        strings = data.manual.panel_strings_attributes.length
        if (fieldsets = $('.string-fields').length) < strings
          for i in [1..(strings - fieldsets)] by 1
            $('.add_fields').trigger('click')
        
        $('form').populate data,
          resetForm: false
          useIndices: true
  
  $(".select-prefill").on 'change', ->
    prefillFields($(this).val(), $(this).attr('id'))
  
  # auto prefill if prefill_id field from previous guy
  if (prefill_id = $('#manual_prefill_id').val())
    prefillFields(prefill_id, $('.select-prefill').attr('id'))
  
  $('.pdf-checkbox').on 'change', ->
    $(this).closest('form').submit()
  
  $('#upload-pdf-fields, .pdfs-submit-btn').hide()
  
  $('#upload-pdfs-btn').on 'click', (e) ->
    e.preventDefault()
    $('.upload-pdfs-input').trigger 'click'
  
  $('.upload-pdfs-input').on 'change', ->
    # check file extensions are .pdf
    for f in this.files
      # http://stackoverflow.com/a/1203361/917850
      if f.name.split('.').pop() != 'pdf'
        return alert('Please choose PDF files')
        
    $('#upload-pdfs-btn').text('Uploading...')
    $('body').addClass('submitting')
    $('.upload-pdfs-form').submit()
  
  # hide checkbox after confirming to delete PDF
  $(document).on 'confirm:complete', (e, answer) ->
    if answer
      $(e.target).closest('label').hide()
  
  # show/hide checkboxes
  $('.showhide input[type=checkbox]:not(:checked)').each ->
    $(this).closest('.showhide').children('.fields').hide()
  $('.showhide input[type=checkbox]').on 'change', ->
    fields = $(this).closest('.showhide').children('.fields')
    if $(this).is(':checked')
      fields.show()
    else
      fields.hide()
    
  # http://railscasts.com/episodes/196-nested-model-form-revised?view=asciicast  
  $('form').on 'click', '.add_fields', (event) ->
    id = $('.string-fields').length
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).parent().before($(this).data('fields').replace(regexp, id))
    event.preventDefault()
    
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('li').slideUp()
    event.preventDefault()
    
    