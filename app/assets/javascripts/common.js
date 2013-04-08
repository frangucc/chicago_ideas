// =require jquery
// =require jquery_ujs
// =require jquery.remotipart

// =require general/utility
// =require general/flash_helper

$(document).ready(function(){
  //show dialog
  $(".s_dialog").click(function(e){
    e.preventDefault();
    content = $($(this).attr("href")).html();
    Utility.open_dialog(content);
  });

});
