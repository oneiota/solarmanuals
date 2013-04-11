replaceSig = (container, url) ->
  container.html("<img src='#{url}' />")
  
replaceInstallerSig = (url) ->
  replaceSig $('#installer-signature'), url

replaceContractorSig = (url) ->
  replaceSig $('#contractor-signature'), url

showHideSigFields = ->
  $('#installer-signature').show()
  
  installerChecked = $('#manual_account_installer').is(':checked')
  $('#installer-signature-sign').toggle(installerChecked)
  $('#installer-signature-email').toggle(!installerChecked)
  
  designerChecked = $('#manual_account_designer').is(':checked')
  console.log designerChecked
  $('#designer-fields').toggle(!designerChecked)
  
$ ->
  
  $(window).on 'load', (e) ->
    $('#signature_box').length && $('#signature_box').sketch()
  
  $('#signature form').on 'submit', (e) ->
    data = $('#signature_box')[0].toDataURL()
    $('.file', this).attr('value', data)
    
  showHideSigFields()
  $('#manual_account_installer, #manual_account_designer').on 'change', (e) ->
    showHideSigFields()

  $('.sign-btn').on 'click', (e) ->
    e.preventDefault()
    w = window.open $(this).attr('href'), 'sig', 'height=400,width=700,toolbar=no'
    w.onunload = ->
      if w.location.origin != 'null'
        
        # convert /asd/123/....whatever
        # to /asd/123
        show_url = window.location.pathname.split('/').slice(0,3).join('/')

        $.getJSON show_url + '.json', (data) ->
          if manual = data && data.manual          
            if installer_url = manual.installer_signature && manual.installer_signature.url
              replaceInstallerSig(installer_url)
          
            if contractor_url = manual.contractor_signature && manual.contractor_signature.url
              replaceContractorSig(contractor_url)