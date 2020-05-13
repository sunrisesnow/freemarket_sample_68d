$(function() {
  // パスワードチェックボックス
  if($(".field").hasClass('error-class')){
    var form = $('.field').children('input');
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

  // 新規登録エラー

  //ニックネーム
  $("#user_nickname").keyup(function(){
    let patern = /[ |　]+/;
    let nickname = $(this).val().match(patern);
    let next = $(this).next();
    if(nickname != null) {
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>ニックネームを入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>ニックネームを入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }  
    }else{
      $(this).css("border", "1px solid #00BFFF")
      next.remove();
    }
  });

  //Eメール
  $('#user_email').keyup(function(){
    let patern = /[\x21-\x3f\x41-\x7e]+@(?:[-a-z0-9]+\.)+[a-z]{2,}/;
    let email = $(this).val().match(patern);
    let next = $(this).next();
    if(email == null){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>フォーマットが正しくありません</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>パスワードが一致しません</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }  
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove();
    }
  });

  //パスワード
  $("#user_password").keyup(function(){
    let patern = /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}$/i;
    let password = $(this).val().match(patern);
    let next = $(this).next();
    if(password == null || $(this).val().length < 7){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>フォーマットが正しくありません</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>パスワードが一致しません</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove();
    }
  });

  //パスワード再入力
  $("#user_password_confirmation").keyup(function(){
    let password = $("#user_password").val();
    let next = $(this).next();
    if($(this).val() != password){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>パスワードが一致しません</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>パスワードが一致しません</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
      
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove();
    }
  });
  
  var first_name = $('[id$=first_name]');
  var last_name = $('[id$=last_name]');
  var first_name_kana = $('[id$=first_name_kana]');
  var last_name_kana = $('[id$=last_name_kana]');
  //姓（全角）
  $(last_name).keyup(function(){
    let patern = /^[ぁ-んァ-ン一-龥]/;
    let last_name_regexp = $(this).val().match(patern);
    let next = $(this).next();
    if(last_name_regexp == null ){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>姓（全角）を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>姓（全角）を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove();
    }
  });

  //名（全角）
  $(first_name).keyup(function(){
    let patern = /^[ぁ-んァ-ン一-龥]/;
    let first_name_regexp = $(this).val().match(patern);
    let next = $(this).next();
    if(first_name_regexp == null ){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>名（全角）を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>名（全角）を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove();
    }
  });

  //姓（カナ）
  $(last_name_kana).keyup(function(){
    let patern = /^[ァ-ヶー－]/;
    let last_name_kana_regexp = $(this).val().match(patern);
    let next = $(this).next();
    if(last_name_kana_regexp == null ){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>姓（カナ）を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>姓（カナ）を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove();
    }
  });

  //名（カナ）
  $(first_name_kana).keyup(function(){
    let patern = /^[ァ-ヶー－]/;
    let first_name_kana_regexp = $(this).val().match(patern);
    let next = $(this).next();
    if(first_name_kana_regexp == null ){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>名（カナ）を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>姓（カナ）を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove();
    }
  });

  //生年月日
  $(".field__birthday > select").on("change", function(){
    let year  = $("#user_birthday_1i").val();
    let month = $("#user_birthday_2i").val();
    let day   = $("#user_birthday_3i").val();
    let next  = $("#user_birthday_3i").next();
    let value = $(this).val();
    if(value != ""){
      $(this).css("border", "1px solid #00BFFF");
    }else{
      $(this).css("border", "1px solid red");
    }
    if(year === "" || day === "" || month === ""){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $("#user_birthday_3i").after(`<div class=error-class2>生年月日を入力してください</div>`);
      }
    }else {
      next.remove(".error-class2");
      next.remove(".error-class");
    }
  });
  //画面遷移しようとした際バリデーションに引っかかった場合
  var next = $("#user_birthday_3i").next();
  if(next.hasClass("error-class")){
    $("select").css("border", "1px solid red");
    $("#user_birthday_1i").css("border", "1px solid red");
    $("#user_birthday_2i").css("border", "1px solid red");
    $("#user_birthday_3i").css("border", "1px solid red");
  }
});

