$(function(){
  Payjp.setPublicKey('pk_test_177d9ddb319e3af144dc305d');
  $("#charge-form").click(function() {
    const btnAfterColor = new Object();
    btnAfterColor.backgroundColor = "#3ccace";
    btnAfterColor.color = "white";
    const form = $("#payjp__form");
    form.find("input[type=submit]").prop("disabled", true);
    $(".btn-default").css(btnAfterColor);
    const card = {
      number: $("#card_number").val(),
      cvc: $("#cvc").val(),
      exp_month: $("#exp_month").val(),
      exp_year: $("#exp_year").val(),
    };
    Payjp.createToken(card, function(status, response) {
      if (response.error){
        alert(`登録に失敗しました。\n存在しないクレジットカードです。`);
        $("#charge-form").prop('disabled', false);
      }   
      else {
        alert("登録に成功しました。");
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        const token = response.id;
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.submit();
      };
    });
  });
});