$(function () {
  // メソッドの定義
  var methods = {
    price: function (value, element) {
      return this.optional(element) || /^[3-9][0-9]{2}|[1-9][0-9]{3,6}$/i.test(value);
    },
  }
  // メソッドの追加
  $.each(methods, function (key) {
    $.validator.addMethod(key, this);
  });
  // バリデーションの実行
  $('#new_item').validate({
    // ルール設定
    rules: {
      "item[images_attributes][0][image]": {
        required: true,
      },
      "item[status_id]": {
        required: true,
      },
      "item[category_id]": {
        required: true,
      },
      "item[delivery_charge_flag]": {
        required: true,
      },
      "item[delivery_date_id]": {
        required: true,
      },
      "item[prefecture_id]": {
        required: true,
      },
      "item[price]": {
        price: true
      },
    },
    messages: {
      "item[images_attributes][0][image]": {
        required: "画像がありません",
      },
      "item[status_id]": {
        required: "選択してください",
      },
      "item[category_id]": {
        required: "選択してください",
      },
      "item[delivery_charge_flag]": {
        required: "選択してください",
      },
      "item[delivery_date_id]": {
        required: "選択してください",
      },
      "item[prefecture_id]": {
        required: "選択してください",
      },
      "item[price]": {
        required: "300以上9,999,999以下で入力してください",
        price: "300以上9,999,999以下で入力してください"
      },
    },
    errorClass: 'error', // バリデーションNGの場合に追加するクラス名の指定
    errorElement: 'p', // エラーメッセージの要素種類の指定
    validClass: 'valid', // バリデーションOKの場合に追加するクラス名の指定
  });



  // 入力欄をフォーカスアウトしたときにバリデーションを実行
  $('#item_images_attributes_0_image').blur(function() {
    $('#item_images_attributes_0_image').focus(function() {
      $('#image-box').on('change', '.js-file', function(e) {
        const file = e.target.files[0];
        const blobUrl = window.URL.createObjectURL(file);

        if (blobUrl == "") {
          console.log('OK')
          $(this).valid();  
        }
        $(this).valid();
        return false;
      });
      $(this).valid();
    })    
  });
  
  $('#new_item input:required').blur(function () {
    $(this).valid();
  });

  $('#new_item select').blur(function () {
    $(this).valid();
  });

  $('#new_item textarea:required').blur(function () {
    $(this).valid();
  });

  // 出品ボタン押下時に、全項目をチェック
  $('#item-post-btn').click(function() {
    var flag = true;
    $('#new_item input:required').each(function(e) {
      if ($('#new_item input:required').eq(e).val() === "") {
        $('#new_item input:required').eq(e).valid();
        flag = false;
      }
    });
    $('#new_item select:required').each(function(e) {
      if ($('#new_item select:required').eq(e).val() === "") {
        $('#new_item select:required').eq(e).valid();
        flag = false;
      }
    });
    $('#new_item textarea:required').each(function(e) {
      if ($('#new_item textarea:required').eq(e).val() === "") {
        $('#new_item textarea:required').eq(e).valid();
        flag = false;
      }
    });
    if (flag) {
      $('#new_item').submit();
    } else {
      console.log('NG')
      $(this).off('submit');
      $('body,html').animate({ scrollTop: 0 }, 500);
    }
  });
});