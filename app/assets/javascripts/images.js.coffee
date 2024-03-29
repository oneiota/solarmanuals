$ ->
  
  canvasSupported = !!document.createElement("canvas").getContext
  
  resizeImage = (image, callback) ->
    $.canvasResize image,
      width: 1350
      height: 1350
      crop: false
      quality: 60
      callback: (data, width, height) ->
        file = $.canvasResize 'dataURLtoBlob', data
        callback(file)
  
  if window.FormData && canvasSupported
    $("#manual_files_array, #submit_manual_images_btn").hide()
    $("#upload-manual-images").css("display", "inline").on "click", (e) ->
      e.preventDefault()
      $("#manual_files_array").trigger("click")
    
    $("#manual_files_array").change (e) ->
      
      $("#manual-images-container").addClass('loading').spin()
      
      url = $(this).closest("form").attr("action")
      fd = new FormData()
      resizedCount = 0
      totalCount = this.files.length
      for f, i in this.files
        resizeImage f, (resizedFile) ->
          resizedCount++
          fd.append("manual[files_array][]", resizedFile)
          
          if resizedCount >= totalCount
          
            $.ajax
              url: url + '.js'
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