$(document).ready ->

  $('a.thank_you_close_button').live 'click', ->
    $.fancybox.close()

  $('a#skip_survey').live 'click', (event) ->
    event.preventDefault()
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
    $('#order_id').val(data)
  ).live('ajax:error', (xhr, data, status) ->
    $main_header = $('#wrapper > #main_header').detach()
    $('#wrapper').empty()
    $('#wrapper').html($main_header).append(data.responseText)
    stButtons.locateElements()
  ).live('ajax:complete', (xhr, data, status) ->
    $.fancybox.hideActivity()
  )

  $('#new_demographic_info').live('ajax:beforeSend', ->
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
  ).live('ajax:complete', (xhr, data, status) ->
    $.fancybox.hideActivity()
  )

  address_ids = ['#order_address_street_1', '#order_address_street_2', '#order_address_city', '#order_address_state', '#order_address_zip', '#order_address_phone']

  $('#same_info_Yes').live 'click', (event) ->
    for address_id in address_ids
      $(address_id).attr 'disabled', 'disabled'

  $('#same_info_No').live 'click', (event) ->
    for address_id in address_ids
      $(address_id).removeAttr 'disabled'
