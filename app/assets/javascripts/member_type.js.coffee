$(document).ready ->
  $('.member_buttons a').live 'hover', 'click', (event) ->
    event.preventDefault()
    member_id = $(this).parent().parent().attr 'data-id'

    $member_type_to_hide = $('.member_type_detailed_container').find '.active_member_type'
    $member_type_to_hide.removeClass 'active_member_type'

    $member_type_to_display = $('.member_type_detailed_container').find "#member_type_#{member_id}"
    $member_type_to_display.addClass 'active_member_type'
