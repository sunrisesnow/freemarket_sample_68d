$(function() {
  // パスワードチェックボックス
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
    let patern = /[^\s]+@[^\s]+/;
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
    let patern = /^[0-9a-zA-Z]*$/;
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

  //年
  $("#user_birthday_1i").change(function(){
    let birthday = $(this).val();
    let day = $("#user_birthday_3i");
    let next = day.next();
    if(birthday == ""){
      if(!$(".error-class").length && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        day.after(`<div class=error-class2>生年月日を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        day.after(`<div class=error-class2>生年月日を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
    }
  });

  //月
  $("#user_birthday_2i").change(function(){
    let birthday = $(this).val();
    let day = $("#user_birthday_3i");
    let next = day.next();
    if(birthday == ""){
      if(!$(".error-class").length && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        day.after(`<div class=error-class2>生年月日を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        day.after(`<div class=error-class2>生年月日を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
    }
  });

  //日
  $("#user_birthday_3i").change(function(){
    let birthday = $(this).val();
    let next = $(this).next();
    if(birthday == ""){
      if(!$(".error-class").length && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>生年月日を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>生年月日を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove(".error-class2");
      next.remove(".error-class");
    }
  });

  //お届け先情報入力画面入力

  //郵便番号
  $("#address_postal_code").keyup(function(){
    let patern = /^[0-9]{7}$/;
    let postal_code = $(this).val().match(patern);
    let next = $(this).next();
    if(postal_code == null) {
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>郵便番号を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>郵便番号を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }  
    }else{
      $(this).css("border", "1px solid #00BFFF")
      next.remove();
    }
  });

  //都道府県
  $('#address_prefectures').change(function(){
    let prefectures = $(this).val();
    let next = $(this).next();
    if(prefectures == null){
      if(!$(".error-class").length && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove(".error-class2");
    }
  });

  //市区町村
  $("#address_municipality").keyup(function(){
    let patern = /[ |　]+/;
    let municipality = $(this).val().match(patern);
    let next = $(this).next();
    if(municipality != null) {
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>市区町村を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>市区町村を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }  
    }else{
      $(this).css("border", "1px solid #00BFFF")
      next.remove();
    }
  });

  //番地
  $("#address_address").keyup(function(){
    let patern = /[ |　]+/;
    let address = $(this).val().match(patern);
    let next = $(this).next();
    if(address != null) {
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>番地を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>番地を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }  
    }else{
      $(this).css("border", "1px solid #00BFFF")
      next.remove();
    }
  });

  //建物名
  $("#address_building").keyup(function(){
    let patern = /[ |　]+/;
    let building = $(this).val().match(patern);
    let next = $(this).next();
    if(building != null) {
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>建物名・部屋番号を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>建物名・部屋番号を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }  
    }else{
      $(this).css("border", "1px solid #00BFFF")
      next.remove();
    }
  });
  
  //電話番号
  $("#address_phone_number").keyup(function(){
    let patern = /^(0{1}\d{9,10})$/;
    let phone_number = $(this).val().match(patern);
    let next = $(this).next();
    if(phone_number == null) {
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>電話番号を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>電話番号を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }  
    }else{
      $(this).css("border", "1px solid #00BFFF")
      next.remove();
    }
  });
});

