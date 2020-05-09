$(function(){
  // PAY.JPの公開鍵をセットします。
  Payjp.setPublicKey('pk_test_177d9ddb319e3af144dc305d');
  //formのsubmitを止めるために, クレジットカード登録のformを定義します。
  var form = $(".form");
  $("#charge-form").click(function() {
    // 二重送信防止のためdisabledをtrueに変更しイベントを止める
    form.find("input[type=submit]").prop("disabled", true);
    // formで入力された、カード情報を取得します。
    var card = {
      number: $("#card_number").val(),
      cvc: $("#cvc").val(),
      exp_month: $("#exp_month").val(),
      exp_year: $("#exp_year").val(),
    };

    // PAYJPに登録するためのトークン作成
    Payjp.createToken(card, function(status, response) {
      if (response.error){
        // エラーがある場合処理しない。
        alert(`登録に失敗しました。\n存在しないクレジットカードです。`);
        //もう一度入力できるようにページをリロードする
        window.location.href = "/cards/new";
      }   
      else {
        // エラーなく問題なく進めた場合
        // formで取得したカード情報を削除して、Appにカード情報を残さない。
        alert("登録に成功しました。");
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        var token = response.id;
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.submit();
      };
    });
  });
});