$ = jQuery;
$(document).ready(function(){
  $('.round').corner("5px");
  $('.round-border').corner("round 5px");
  $(".notes").corner("round 10px");
  $(".round_plain.highlighted").corner("round 4px");
  $(".round_plain.nav_action").corner("round 5px");
  
  $("form input[type='submit']").click(function(){
      $(this).val("Processing...");
      $(this).attr("disabled", "disabled");
      $(this).blur();
  });
  $("form input[type='submit']").removeAttr("disabled");
});
