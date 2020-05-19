// 入力フォームのバリデーション
$(function() {
  let value;
  let next;
  let priceNext;
  let imageNext;

  // blur時の動作
  function fieldBlur(input) {
    value = input.val();
    next = input.next();
    priceNext = input.parent().parent().next();
    // 未入力のチェック
    if (value == "" && !next.hasClass('error')) {
      input.addClass('error');
      if (input.is('select')) {
        input.after(`<p class='error'>選択してください</p>`);
      } else if (input.is('#sell-price-input') || input.is('.img-file')) {
        ;
      } else {
        input.after(`<p class='error'>入力してください</p>`);  
      }
    } else {
      input.removeClass('error');
      next.remove();
    }

    // 金額入力の入力チェック
    if (input.is('#sell-price-input')) {
      if (value == "" || value < 300 || value >= 10000000) {
        if (!priceNext.hasClass('error')) {
          input.parent().parent().after(`<p class='error price-error'>300以上10,000,000未満で入力してください</p>`);
        }
      } else if (priceNext.hasClass('error')) {
        priceNext.remove();
      } else {
        ;
      }
    }
  }
  // keyup時の動作
  function fieldKeyup(input) {
    value = input.val();
    next = input.next();
    priceNext = input.parent().parent().next();
    if (value != "") {
      input.removeClass('error');
      if (input.is('#sell-price-input')) {
        ;
      } else {
        next.remove();
      }
    }
    // 金額入力の入力チェック
    if (input.is('#sell-price-input')) {
      if (value >= 300 && value < 10000000) {
        if (priceNext.hasClass('error')) {
          priceNext.remove();
        }
      } else if (!priceNext.hasClass('error')) {
        input.parent().parent().after(`<p class='error price-error'>300以上10,000,000未満で入力してください</p>`);
      } else {
        ;
      }
    }
  }

  // 画像の入力チェック
  function imageCheck(num) {
    const imageNext = $('#image-box-1').next();
    if (num == 0) {
      if (!imageNext.hasClass('error')) {
        $('#image-box-1').after(`<p class='error'>画像がありません</p>`);
      }
    } else {
      if (imageNext.hasClass('error')) {
        imageNext.remove();
      }
    }
  }

  $('.edit_item input:required').on('blur', function() {
    fieldBlur($(this));
  });

  $('.edit_item input:required').on('keyup', function() {
    fieldKeyup($(this));
  });

  $('.edit_item textarea').on('blur', function() {
    fieldBlur($(this));
  });

  $('.edit_item textarea').on('keyup', function() {
    fieldKeyup($(this));
  });

  $('.edit_item select').on('blur change', function() {
    fieldBlur($(this));
  });

  // 出品ボタン押下時の処理
  $('.item-btn').click(function(e) {
    e.preventDefault();
    const submitID = $(this).attr('id')
    let flag = true;
    const num = $('.item-image').length - 1
    console.log(num)
    imageCheck(num);

    $('.edit_item input:required').each(function(e) {
      if ($('.edit_item input:required').eq(e).val() === "") {
        fieldBlur($('.edit_item input:required').eq(e));
        flag = false;
      }
    });
    $('.edit_item textarea:required').each(function(e) {
      if ($('.edit_item textarea:required').eq(e).val() === "") {
        fieldBlur($('.edit_item textarea:required').eq(e));
        flag = false;
      }
    });
    $('.edit_item select').each(function(e) {
      if ($('.edit_item select').eq(e).val() === "") {
        fieldBlur($('.edit_item select').eq(e));
        flag = false;
      }
    });

    if (flag) {
      if (submitID == 'item-post-btn') {
        $("input[name='item[trading_status_id]']").val(1);
        $('.edit_item').submit();
      } else {
        $("input[name='item[trading_status_id]']").val(4);
        $('.edit_item').submit();
      }
    } else {
      $(this).off('submit');
      $('body,html').animate({ scrollTop: 0 }, 500);
      return false;
    }
  });
});