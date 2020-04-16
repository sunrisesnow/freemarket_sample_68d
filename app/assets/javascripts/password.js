$(function() {
  $("#checkpw").change(function(){
    if($(this).prop('checked')){
      $('.pwform').attr('type','text');
    }else{
      $('.pwform').attr('type','password');
    }
  });
});