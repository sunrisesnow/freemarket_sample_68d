// 並び替えの挙動
$(function() {
  // プルダウンメニューを選択することでイベントが発生
  $('select[name=sort_order]').change(function() {
    console.log('OK')
    // 選択したoptionタグのvalue属性を取得する
    const sort_order = $(this).val();
    // value属性の値により、ページ遷移先の分岐

    switch (sort_order) {
      case 'price-asc': html = "&sort=price+asc"; break;
      case 'price-desc': html = "&sort=price+desc"; break;
      case 'created_at-asc': html = "&sort=created_at+asc"; break;
      case 'created_at-desc': html = "&sort=created_at+desc"; break;
      default: html = "&sort=created_at+desc"; 
    }
    // 現在の表示ページ
    let current_html = window.location.href;
    // ソート機能の重複防止 
    if (location['href'].match(/&sort=*.+/) != null) {
      var remove = location['href'].match(/&sort=*.+/)[0]
      current_html = current_html.replace(remove, '')
    };
    // ページ遷移
    window.location.href = current_html + html
  });
  // ページ遷移後の挙動
  $(function () {
    if (location['href'].match(/&sort=*.+/) != null) {
      // option[selected: 'selected']を削除
      if ($('select option[selected=selected]')) {
        $('select option:first').prop('selected', false);
      }

      const selected_option = location['href'].match(/&sort=*.+/)[0].replace('&sort=', '');

      switch (selected_option) {
        case "price+asc": var sort = 1; break;
        case "price+desc": var sort = 2; break;
        case "created_at+asc": var sort = 3; break;
        case "created_at+desc": var sort = 4; break;
        default: var sort = 4
      }
      const add_selected = $('select[name=sort_order]').children()[sort]
      $(add_selected).attr('selected', true)
    }
  });
});

// 検索条件の挙動
$(function(){
  const min_price = $('#q_price_gteq');
  const max_price = $('#q_price_lteq');

  // 価格帯を選択したら、minとmaxに値を
  $('#price_range').on('change', function() {
    const price_range = $(this).val();
    if (price_range != "") {
      $.ajax({
        url: '/items/price_range',
        type: 'GET',
        data: { price_id: price_range},
        dataType: 'json'
      })
      .done(function(range) {
        min_price.val(range.min);
        max_price.val(range.max);
      })
      .fail(function() {
        alert('価格帯の取得に失敗しました')
      })
    } else {
      min_price.val('');
      max_price.val('');
    }
  });
});
