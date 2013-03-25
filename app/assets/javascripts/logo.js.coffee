$ ->
  if !$("html").hasClass('shit')
    $(".logo-form").hide()
    $("#upload-logo-btn").on "click", (e) ->
      e.preventDefault()
      $("#user_logo").trigger("click")
  

  $("#user_logo").bind "change", ->
    #unless this.files[0].type in ['image/jpg', 'image/png', 'image/jpeg']
    #  return alert("Please upload a JPG or PNG image.")
    
    if !$('html').hasClass('shit')
      if this.files[0].size > 2097152
        return alert("Please upload a logo less than 2MB")
  
    $(".logo-form").submit()
    $("#upload-logo-btn").html("Uploading...")
    
    if !$('html').hasClass('shit')
      $("#user-logo").spin(opts).find("img").fadeTo(100, 0.1)
      
