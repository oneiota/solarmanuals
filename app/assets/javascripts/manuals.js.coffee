$ ->
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
  
  if window.FormData
    $("#manual_files_array, #submit_manual_images_btn").hide()
    $("#upload-manual-images").show().on "click", (e) ->
      e.preventDefault()
      $("#manual_files_array").trigger("click")
    
    $("#manual_files_array").change (e) ->
    
      $("#manual-images-container").addClass('loading').spin()
    
      form = $(this).closest("form")
      fd = new FormData()
      for f, i in this.files
        fd.append("manual[files_array][]", f)
      
      $.ajax
        url: form.attr("action") + '.js'
        type: 'PUT'
        data: fd
        processData: false
        contentType: false
        success: (data) ->
          console.log(data)
        error: (data) ->
          console.log(data)
        progress: (e) ->
          if e.lengthComputable
            pct = (e.loaded / e.total) * 100
            console.log(pct)