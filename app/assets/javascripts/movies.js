$(document).ready(function(){
  $('#browse-button').click(function(){
    if($('.row').length > 1) {
      $('.row').last().remove();
    }
  });
});