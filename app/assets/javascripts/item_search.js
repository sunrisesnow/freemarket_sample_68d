// 並び替えの挙動
$(function() {
  // プルダウンメニューを選択することでイベントが発生
  $('select[name=sort_order]').change(function() {
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
  let grandchild_category_all_checkbox = $('#grandchildren_category_all');
  let grandchild_category_checkboxes = $('input[name="q[category_id_in][]"]');
  const status_all_checkbox = $('#status_all');
  const status_checkboxes = $('input[name="q[status_id_in][]"]')
  const delivery_charge_all_checkbox = $('#delivery_charge_flag_all')
  const delivery_charge_checkboxes = $('input[name="q[delivery_charge_flag_in][]"]')
  const trading_status_all_checkbox = $('#trading_status_all')
  const trading_status_checkboxes = $('input[name="q[trading_status_id_in][]"]')

  // 「すべて」をクリックした時の挙動
  $(document).on('change', '.js-checkbox-all', function() {
    function targetCheckboxesChage(target, trigger) {
      if (trigger.prop("checked") == true) {
        target.prop("checked", true);
      } else {
        target.prop("checked", false);
      }
    }

    let target_checkboxes;
    switch ($(this).prop('id')) {
      case $('#grandchildren_category_all').prop('id'):
        target_checkboxes = $('input[name="q[category_id_in][]"]');
        break;
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

  // 「すべて」以外をクリックした時の挙動
  $(document).on('change', '.js_search_checkbox > input:checkbox', function() {
    function allCheckboxChange(target, all_checkbox, trigger) {
      if (trigger.prop("checked") == false) {
        all_checkbox.prop("checked", false);
      } else {
        let flag = true
        target.each(function(e) {
          if (target.eq(e).prop("checked") == false) {
            flag = false;
          }
        });
        if (flag) {
          all_checkbox.prop("checked", true);
        }
      }
    }  
    let all_checkbox;
    grandchild_category_all_checkbox = $('#grandchildren_category_all');
    grandchild_category_checkboxes = $('input[name="q[category_id_in][]"]');
    switch ($(this).prop('name')) {
      case grandchild_category_checkboxes.prop('name'):
        target_checkboxes = grandchild_category_checkboxes;
        all_checkbox = grandchild_category_all_checkbox;
        break;
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


  // ページ読み込み時の、チェックボックス「すべて」にチェックを入れるか判定する関数
  function loadCheckboxSlection(target, all_checkbox) {
    let flag = true;
    target.each(function(e) {
      if (target.eq(e).prop("checked") == false) {
        flag = false;
      }
    });
    if (flag) {
      all_checkbox.prop("checked", true);
    }
  }

  // ページ読み込み時に、チェックボックス「すべて」にチェックを入れるか判定する関数を走らせる
  if ($('#item_search_form').length) {
    loadCheckboxSlection(grandchild_category_checkboxes ,grandchild_category_all_checkbox)
    loadCheckboxSlection(status_checkboxes, status_all_checkbox)
    loadCheckboxSlection(delivery_charge_checkboxes, delivery_charge_all_checkbox)
    loadCheckboxSlection(trading_status_checkboxes, trading_status_all_checkbox)

    if (min_price.val() != "" && max_price.val() != "") {
      $.ajax({
        url: '/items/price_range',
        type: 'GET',
        data: { min: min_price.val(), max: max_price.val()},
        dataType: 'json'
      })
      .done(function(range) {
        if (range) {
          $('#price_range').val(range.id);
        }
      })
      .fail(function() {
        alert('価格帯の取得に失敗しました')
      })
    }
  }

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
  
  // 検索フォームでのカテゴリーの挙動
  function appendOption(category){
    let html = `<option value="${category.id}" >${category.name}</option>`;
    return html;
  }

  function appendCheckbox(category){
    let html =`
                <div class="sc-side__detail__field__form--checkbox">
                  <div class="sc-side__detail__field__form--checkbox__btn js_search_checkbox">
                    <input type="checkbox" value="${category.id}" name="q[category_id_in][]" id="q_category_id_in_${category.id}" >
                  </div>
                  <div class="sc-side__detail__field__form--checkbox__label">
                    <label for="q_category_id_in_${category.id}">${category.name}</label>
                  </div>
                </div>
                `
    return html;
  }

  // 子カテゴリーの表示作成
  function appendChildrenBox(insertHTML){
    const childSelectHtml = `<li>
                              <select id="children_category_search" name="q[category_id]">
                                <option value="">選択してください</option>
                                ${insertHTML}
                              </select>
                            </li>`;
    $('.field__input--category_search').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchildrenBox(insertHTML){
    const grandchildSelectHtml =`
                                <li id="grandchildren_category_checkboxes" class="checkbox-list">
                                  <div class="sc-side__detail__field__form--checkbox js_search_checkbox-all">
                                    <div class="sc-side__detail__field__form--checkbox__btn">
                                      <input class="js-checkbox-all" id="grandchildren_category_all" type="checkbox">
                                    </div>
                                    <div class="sc-side__detail__field__form--checkbox__label">
                                      <label for="grandchildren_category_all">すべて</label>
                                    </div>
                                  </div>
                                  ${insertHTML}
                                </li>`;
    $('.field__input--category_search').append(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#parent_category_search').on('change', function(){
    //選択された親カテゴリーの名前を取得
    const parentName =$(this).val(); 
    if (parentName != ""){ 
      //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/category_children',
        type: 'GET',
        data: { parent_name: parentName },
        dataType: 'json'
      })
      .done(function(children){
         //親が変更された時、子以下を削除する
        $('#children_category_search').remove();
        $('#grandchildren_category_checkboxes').remove();
        let insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      //親カテゴリーが初期値になった時、子以下を削除する
      $('#children_category_search').remove();
      $('#grandchildren_category_checkboxes').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('.field__input--category_search').on('change', '#children_category_search', function(){
    const childId = $(this).val();
    //選択された子カテゴリーのidを取得
    if (childId != ""){ 
      //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/category_grandchildren',
        type: 'GET',
        data: { child_id:  childId},
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          //子が変更された時、孫以下を削除する
          $('#grandchildren_category_checkboxes').remove();
          let insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendCheckbox(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_category_checkboxes').remove();
    }
  });

  $('#detail_search_btn').click(function(e) {
    if ($('#children_category_search').val() == "") {
      $('#children_category_search').remove();
    }
  });
});

"use strict";

// clearボタンを押した時の動作
$(function () {
  $("#js_conditions_clear").on("click", function () {
      clearForm(this.form);
  });

  function clearForm (form) {
    $(form)
        .find("input, select, textarea")
        .not(":button, :submit, :reset, :hidden")
        .val("")
        .prop("checked", false)
        .prop("selected", false)
    ;
    $('#children_category_search').remove();
    $('#grandchildren_category_checkboxes').remove();
  }
});
