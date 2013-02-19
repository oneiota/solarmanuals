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
  
  
  $("#upload-logo-btn").on "click", (e) ->
    e.preventDefault()
    $("#user_logo").trigger("click")
  
  $("#user_logo").on "change", ->
    #unless this.files[0].type in ['image/jpg', 'image/png', 'image/jpeg']
    #  return alert("Please upload a JPG or PNG image.")
    if this.files[0].size > 2097152
      return alert("Please upload a logo less than 2MB")
    
    $(".logo-form").submit()
    $("#upload-logo-btn").html("Uploading...")
    $("#user-logo").spin(opts).find("img").fadeTo(100, 0.1)
      
  $("#submit-subscription").on "click", (e) ->
    e.preventDefault()
    $(this).closest("form").submit()
    $("#subscription-loading").show()
  
  
  $(".select-prefill").on 'change', ->
    params = {
      type: $(this).attr('id')
    }
    $.ajax
      url: '/manuals/'+$(this).val()
      dataType: 'json'
      data: params
      success: (data) ->
        realData = {
          'manual' : data
        }
        $('form').populate realData,
          resetForm: false
  
  
  $('.pdf-checkbox').on 'change', ->
    $(this).closest('form').submit()
      
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
    