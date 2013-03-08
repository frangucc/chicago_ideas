$(document).ready ->

  $('a.thank_you_close_button').live 'click', ->
    $.fancybox.close()

  $('a#skip_survey').live 'click', ->
    $.fancybox.close()
    $.fancybox
      content: $('#thank_you_modal')
      autoDimensions: true
      autoScale: true
      padding: 0
      margin: 0
      showCloseButton: false
      hideOnContentClick: false
      hideOnOverlayClick: false
      centerOnScroll: true

  $('a#send_survey').live 'click', ->
    $.fancybox.close()
    $.fancybox
      content: $('#thank_you_modal')
      autoDimensions: true
      autoScale: true
      padding: 0
      margin: 0
      showCloseButton: false
      hideOnContentClick: false
      hideOnOverlayClick: false
      centerOnScroll: true
    # TODO: SEND SURVEY

  $('#new_order').live('ajax:beforeSend', ->
    $.fancybox.showActivity()
  ).live('ajax:success', (xhr, data, status) ->
    $.fancybox
      content: $('#demographic_modal')
      autoDimensions: true
      autoScale: true
      padding: 0
      margin: 0
      showCloseButton: false
      hideOnContentClick: false
      hideOnOverlayClick: false
      centerOnScroll: true
  ).live('ajax:error', (xhr, data, status) ->
    $main_header = $('#wrapper > #main_header').detach()
    $('#wrapper').empty()
    $('#wrapper').html($main_header).append(data.responseText)
    stButtons.locateElements()
  ).live('ajax:complete', (xhr, data, status) ->
    $.fancybox.hideActivity()
  )
