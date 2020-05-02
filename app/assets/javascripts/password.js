$(function() {
  if($(".field").hasClass('error-class')){
    var form = $('.field').children('input');
    console.log("ok");
  }
  $("#checkpw").change(function(){
    if($(this).prop('checked')){
      $('#user_password').attr('type','text');
      $('#user_password_confirmation').attr('type','text');
    }else{
      $('#user_password').attr('type','password');
      $('#user_password_confirmation').attr('type','password');
    }
  });

  // 新規登録動的エラー

  //ニックネーム
  $("#user_nickname").keyup(function(){
    let nickname = $(this).val();
    if(nickname == " " || nickname == "" || nickname == "　"){
      if(!$('.error-class').length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
        $(this).after(`<div class=error-class2>ニックネームを入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }  
    }else{
      $(this).css("border", "1px solid #00BFFF")
      $(".error-class2").remove();
    }
  })

  //Eメール
  $('#user_email').keyup(function(){
    let patern = /[^\s]+@[^\s]+/;
    let email = $(this).val().match(patern);
    if(email == null){
      if(!$('.error-class').length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
        $(this).after(`<div class=error-class2>フォーマットが正しくありません</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }  
    }else{
      $(this).css("border", "1px solid #00BFFF");
      $(".error-class2").remove();
    }
  });

  //パスワード
  $("#user_password").keyup(function(){
    let patern = /^[0-9a-zA-Z]*$/;
    let password = $(this).val().match(patern);
    if(password == null || $(this).val().length < 7){
      if(!$(".error-class").length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
        $(this).after(`<div class=error-class2>フォーマットが正しくありません</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      $(".error-class2").remove();
    }
  });

  //パスワード再入力
  $("#user_password_confirmation").keyup(function(){
    let password = $("#user_password").val();
    console.log(password);
    if($(this).val() != password){
      console.log("ok")
      if(!$(".error-class").length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
        $(this).after(`<div class=error-class2>パスワードが一致しません</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      $(".error-class2").remove();
    }
  });

  //姓（全角）
  $("#user_last_name").keyup(function(){
    let patern = /^[ぁ-んァ-ン一-龥]/;
    let last_name_regexp = $(this).val().match(patern);
    if(last_name_regexp == null ){
      if(!$(".error-class").length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
        $(this).after(`<div class=error-class2>姓（カナ）を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      $(".error-class2").remove();
    }
  });

  //名（全角）
  $("#user_first_name").keyup(function(){
    let patern = /^[ぁ-んァ-ン一-龥]/;
    let first_name_regexp = $(this).val().match(patern);
    if(first_name_regexp == null ){
      if(!$(".error-class").length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
        $(this).after(`<div class=error-class2>名（全角）を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      $(".error-class2").remove();
    }
  });

  //姓（カナ）
  $("#user_last_name_kana").keyup(function(){
    let patern = /^[ァ-ヶー－]/;
    let last_name_kana_regexp = $(this).val().match(patern);
    if(last_name_kana_regexp == null ){
      if(!$(".error-class").length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
        $(this).after(`<div class=error-class2>姓（カナ）を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      $(".error-class2").remove();
    }
  });

  //名（カナ）
  $("#user_first_name_kana").keyup(function(){
    let patern = /^[ァ-ヶー－]/;
    let first_name_kana_regexp = $(this).val().match(patern);
    if(first_name_kana_regexp == null ){
      if(!$(".error-class").length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
        $(this).after(`<div class=error-class2>名（カナ）を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      $(".error-class2").remove();
    }
  });

  //年
  $("#user_birthday_1i").change(function(){
    console.log($(this).val());
    let birthday = $(this).val();
    if(birthday == ""){
      if(!$(".error-class").length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      $(".error-class2").remove();
    }
  });

  //月
  $("#user_birthday_2i").change(function(){
    console.log($(this).val());
    let birthday = $(this).val();
    if(birthday == ""){
      if(!$(".error-class").length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      $(".error-class2").remove();
    }
  });

  //日
  $("#user_birthday_3i").change(function(){
    console.log($(this).val());
    let birthday = $(this).val();
    if(birthday == ""){
      if(!$(".error-class").length && !$(".error-class2").length){
        $(this).css("border", "1px solid red").css("backgroundColor", "white");
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      $(".error-class2").remove();
    }
  });
});