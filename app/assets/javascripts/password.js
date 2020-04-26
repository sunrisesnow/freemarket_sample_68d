$(function() {
  $("#checkpw").change(function(){
    if($(this).prop('checked')){
      $('#user_password').attr('type','text');
      $('#user_password_confirmation').attr('type','text');
    }else{
      $('#user_password').attr('type','password');
      $('#user_password_confirmation').attr('type','password');
    }
  });
});