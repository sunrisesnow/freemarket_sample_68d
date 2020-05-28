$(function(){
  //郵便番号を入力することで住所自動入力
  $("#address_postal_code").jpostal({
    postcode : [ "#address_postal_code" ],
    address  : {
                  "#address_prefectures" : "%3",
                  "#address_municipality"            : "%4",
                  "#address_address"          : "%5%6%7"
                }
  });
  
  //input要素の中でerrorが出たクラスがあった際errorが出たinput要素にフォーカス
  if($('input').hasClass("error-class")){
    $(".error-class:first").focus();
    $("input[class=error-class]").css("border", "1px solid red");
  }else{
  //errorを含むinput要素がない時ページ先頭のinput要素フォーカス
    $('input[type=text]:first').focus();
  }
  $('input').on("keydown", function(e) {
      //全てのinputの数取得
      const n = $("input").length;
      //13=エンターキーのキー番号らしい
      if (e.which == 13)
      {
          e.preventDefault();
          const nextIndex = $('input').index(this) + 1;
          //現在フォーカスされているインプット要素のindex番号と総数を比べて条件分岐
          if(nextIndex < n) {
              //次のやつにfocus
              $('input')[nextIndex].focus();
          }
      }
  });
  //お届け先情報入力画面入力

  //郵便番号
  $("#address_postal_code").keyup(function(){
    const patern = /^[0-9]{7}$/;
    const postal_code = $(this).val().match(patern);
    const next = $(this).next();
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
  $('#address_prefectures').on("change", function(){
    const prefectures = $(this).val();
    const next = $(this).next();
    if(prefectures === ""){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>都道府県を入力してください</div>`);
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
    const patern = /[ |　]+/;
    const municipality = $(this).val().match(patern);
    const next = $(this).next();
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
    const patern = /[ |　]+/;
    const address = $(this).val().match(patern);
    const next = $(this).next();
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
    const patern = /[ |　]+/;
    const building = $(this).val().match(patern);
    const next = $(this).next();
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
    const patern = /^(0{1}\d{9,10})$/;
    const phone_number = $(this).val();
    const next = $(this).next();
    if(phone_number != "" && phone_number.match(patern) == null) {
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
  
  //発送元・お届け先住所変更時のバリデーションチェック

  $('.change__address__btn').click(function(e) {
    e.preventDefault();
    let flag = true;
    const patern = /^(0{1}\d{9,10})$/;
    const phone_number = $("#address_phone_number").val()
    if(phone_number != "" && phone_number.match(patern) == null){
      flag = false;
    }
    $('#edit_address input:required').each(function(e) {
      if ($('#edit_address input:required').eq(e).val() === "") {
        flag = false;
      }
    });
    $('#edit_address textarea:required').each(function(e) {
      if ($('#edit_address textarea:required').eq(e).val() === "") {
        flag = false;
      }
    });
    $('#edit_address select').each(function(e) {
      if ($('#edit_address select').eq(e).val() === "") {
        flag = false;
      }
    });
    
    if (flag) {
      $('#edit_address').submit();
    } else {
      const errorInput = $(".error-class2:first").prev();
      const position = errorInput.offset().top - 40;
      const speed = 400;
      $(this).off('submit');
      $('body,html').animate({scrollTop:position}, speed, 'swing');
      errorInput.focus();
      return false;
    }
  });
});