$(document).ready ->

  $('a.thank_you_close_button') .live "click", ->
    $.fancybox.close()

  $('#new_cooperative_application').live('ajax:beforeSend', ->
    $.fancybox.showActivity()
  ).live('ajax:success', (xhr, data, status) ->
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
  ).live('ajax:error', (xhr, data, status) ->
    $main_header = $('#wrapper > #main_header').detach()
    $('#wrapper').empty()
    $('#wrapper').html($main_header).append(data.responseText)
    twttr.widgets.load()
    FB.XFBML.parse()
  ).live('ajax:complete', (xhr, data, status) ->
    $.fancybox.hideActivity()
  )
