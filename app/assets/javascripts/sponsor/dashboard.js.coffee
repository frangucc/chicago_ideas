$(document).ready ->

  sponsorInactive = $('.hidden_dashboard').data('sponsor-active') is false

  if sponsorInactive
    $.fancybox
      content: $('#activation_modal')
      autoDimensions: true
      autoScale: true
      padding: 0
      margin: 0
      showCloseButton: false
      hideOnContentClick: false
      hideOnOverlayClick: false
      enableEscapeButton: false
      centerOnScroll: true

  $('#activation_modal form').live('ajax:beforeSend', ->
    $.fancybox.showActivity()
  ).live('ajax:success', (xhr, data, status) ->
    $.fancybox.close()
  ).live('ajax:error', (xhr, data, status) ->
    $('.upload_errors').html ''
    errors = data.responseText
    printUploadErrors errors
  ).live('ajax:complete', (xhr, data, status) ->
    $.fancybox.hideActivity()
  )

  $('#new_user').live('ajax:beforeSend', ->
    $('.errors').html ''
    $('.message').html ''
    $('#submit_request').val 'sending...'
    $('#loading_image').removeClass 'hidden'
  ).live('ajax:success', (xhr, data, status) ->
    $('.message').html 'Sent invite email successfully'
    $('#new_user #user_name').val ''
    $('#new_user #user_email').val ''
  ).live('ajax:error', (xhr, data, status) ->
    errors = data.responseText
    printInviteErrors errors
  ).live('ajax:complete', (xhr, data, status) ->
    $('#submit_request').val 'Add another sponsor admin'
    $('#loading_image').addClass 'hidden'
  )

  $('.list-sponsor .span a').live('ajax:success', (xhr, data, status) ->
    $(this).parent().remove()
  )

printInviteErrors = (errors) ->
  $('.errors').append "<li>#{error}</li>" for error in $.parseJSON(errors)

printUploadErrors = (errors) ->
  $('.upload_errors').append "<li>#{error}</li>" for error in $.parseJSON(errors)
