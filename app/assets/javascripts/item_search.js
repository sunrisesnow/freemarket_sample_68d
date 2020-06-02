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

  // 価格帯を選択したら、minとmaxに値を
  $('#price_range').on('change', function() {
    const price_range = $(this).val();
    const min_price = $('#q_price_gteq')
    const max_price = $('#q_price_lteq')

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
    }
    
  });

  // 検索条件のチェックボックスの挙動
  const checkbox_all_select = $('.js-checkbox-all');
  const status_all_checkbox = $('#status_all');
  const status_checkboxes = $('input[name="q[status_id_in][]"]')
  const delivery_charge_all_checkbox = $('#delivery_charge_flag_all')
  const delivery_charge_checkboxes = $('input[name="q[delivery_charge_flag_in][]"]')
  const trading_status_all_checkbox = $('#trading_status_all')
  const trading_status_checkboxes = $('input[name="q[trading_status_id_in][]"]')
  
  // 「すべて」をクリックした時の挙動
  function targetCheckboxesChage(target, trigger) {
    if (trigger.prop("checked") == true) {
      target.prop("checked", true);
    } else {
      target.prop("checked", false);
    }
  }

  // 「すべて」以外をクリックした時の挙動
  function allCheckboxChange(target, all_checkbox, trigger) {
    if (trigger.prop("checked") == false) {
      all_checkbox.prop("checked", false);
    } else {
      let flag = true
      target_checkboxes.each(function(e) {
        if (target_checkboxes.eq(e).prop("checked") == false) {
          flag = false;
        }
      });
      if (flag) {
        all_checkbox.prop("checked", true);
      }
    }
  }

  $('.js_search_checkbox-all > input:checkbox').on('change', function() {
    let target_checkboxes;
    switch ($(this).prop('id')) {
      case status_all_checkbox.prop('id'):
        target_checkboxes = status_checkboxes;
        break;
      case delivery_charge_all_checkbox.prop('id'):
        target_checkboxes = delivery_charge_checkboxes;
        break;
      case trading_status_all_checkbox.prop('id'):
        target_checkboxes = trading_status_checkboxes;
        break;
      default: ;
    }
    targetCheckboxesChage(target_checkboxes, $(this));
  });

  $('.js_search_checkbox > input:checkbox').on('change', function() {
    let all_checkbox;
    switch ($(this).prop('name')) {
      case status_checkboxes.prop('name'):
        target_checkboxes = status_checkboxes;
        all_checkbox = status_all_checkbox;
        break;
      case delivery_charge_checkboxes.prop('name'):
        target_checkboxes = delivery_charge_checkboxes;
        all_checkbox = delivery_charge_all_checkbox;
        break;
      case trading_status_checkboxes.prop('name'):
        target_checkboxes = trading_status_checkboxes;
        all_checkbox = trading_status_all_checkbox;
        break;
      default: ;
    }
    allCheckboxChange(target_checkboxes, all_checkbox, $(this));
  });

  // クリアボタン押下で条件を全クリア
  $('#js_conditions_clear').click(function(e) {
    checkbox_all_select.prop("checked", false);
    status_checkboxes.prop("checked", false);
    delivery_charge_checkboxes.prop("checked", false);
    trading_status_checkboxes.prop("checked", false);
  });
});
