$(document).ready ->

  #$.fancybox
    #content: $('#activation_modal')
    #autoDimensions: true
    #autoScale: true
    #padding: 0
    #margin: 0
    #showCloseButton: false
    #hideOnContentClick: false
    #hideOnOverlayClick: false
    #centerOnScroll: true

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
    printErrors errors
  ).live('ajax:complete', (xhr, data, status) ->
    $('#submit_request').val 'Add another sponsor admin'
    $('#loading_image').addClass 'hidden'
  )

printErrors = (errors) ->
  $('.errors').append "<li>#{error}</li>" for error in eval(errors)
