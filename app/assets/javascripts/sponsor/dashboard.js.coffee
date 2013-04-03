$(document).ready ->
  $("a#submit_request").live "click", (event) ->
    event.preventDefault()
    $(".errors").html ""
    $(".message").html ""
    if $(this).text() is "Send Invite"
      $("#request_admin input#name").val $("#request_name").val()
      $("#request_admin input#email").val $("#request_email").val()
      $(this).html "sending..."
      $("#loading_image").removeClass "hidden"
      $("#request_admin").submit()
