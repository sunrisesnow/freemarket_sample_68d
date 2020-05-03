var parentBeforeColor = new Object();
parentBeforeColor.backgroundColor = "white";
parentBeforeColor.color = "black";
var parentAfterColor = new Object();
parentAfterColor.backgroundColor = "#3ccace";
parentAfterColor.color = "white";
var childBeforeColor = new Object();
childBeforeColor.backgroundColor = "white";
var childAfterColor = new Object();
childAfterColor.backgroundColor = "whitesmoke";


$(function(){
  // #で始まるリンクをクリックしたら実行されます
  $('a[href^="#"]').click(function() {
    // スクロールの速度
    var speed = 400; // ミリ秒で記述
    var href= $(this).attr("href");
    var target = $(href == "#" || href == "" ? 'html' : href);
    var position = target.offset().top;
    $('body,html').animate({scrollTop:position}, speed, 'swing');
    return false;
  });

  // カテゴリーボックスの動的背景色変化
  
  // 親要素にmouseoverした時、親要素のcss変化（mouseoverした時も変化）
  $('.category__parent--name').mouseover(function(){
    $(this).css(parentAfterColor);
  }).mouseout(function(){
    $(this).css(parentBeforeColor);
  });

  // 子要素にmouseoverした時、子要素、子要素の親要素css変化（mouseoverした時も変化）
  $('.category__child--name').mouseover(function(){
    let parent = $(this).parent().parent().parent().children('a');
    $(this).css(childAfterColor);
    parent.css(parentAfterColor);
  }).mouseout(function(){
    let parent = $(this).parent().parent().parent().children('a');
    $(this).css(childBeforeColor);
    parent.css(parentBeforeColor);
  });

  // 孫要素にmouseoverした時、孫要素、孫要素の親要素、孫要素の祖先要素css変化（mouseoverした時も変化）
  $('.category__grandchild--name').mouseover(function(){
    let child  = $(this).parent().parent().parent().children('a');
    let parent = child.parent().parent().parent().children('a');
    $(this).css(childAfterColor);
    child.css(childAfterColor);
    parent.css(parentAfterColor);
  }).mouseout(function(){
    let child  = $(this).parent().parent().parent().children('a');
    let parent = child.parent().parent().parent().children('a');
    $(this).css(childBeforeColor);
    child.css(childBeforeColor);
    parent.css(parentBeforeColor);
  });

  $(function(){
    // カテゴリーセレクトボックスのオプションを作成
    function appendOption(category){
      var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    // 子カテゴリーの表示作成
    function appendChidrenBox(insertHTML){
      var childSelectHtml = `<li>
                              <select  id=children_category name=item[category] class=valid aria-invalid=false>
                                <option value=選択してください>選択してください</option>
                                ${insertHTML}
                              </select>
                            </li>`;
       //カテゴリーフォームの一番下に追加
      $('.field__input--category').append(childSelectHtml);
    }
    // 孫カテゴリーの表示作成
    function appendGrandchidrenBox(insertHTML){
      var grandchildSelectHtml = `<li>
                                    <select id=grandchildren_category name=item[category] class=valid aria-invalid=false>
                                      <option value="選択してください">選択してください</option>
                                      ${insertHTML}
                                    </select>
                                  </li>`;
      //カテゴリーフォームの一番下に追加
      $('.field__input--category').append(grandchildSelectHtml);
    }
    // 親カテゴリー選択後のイベント
    $('#parent_category').on('change', function(){
      var parentCategory = document.getElementById("parent_category").value; 
      //選択された親カテゴリーの名前を取得
      if (parentCategory != "選択してください"){ 
        //親カテゴリーが初期値でないことを確認
        $.ajax({
          url: 'category_children',
          type: 'GET',
          data: { parent_name: parentCategory },
          dataType: 'json'
        })
        .done(function(children){
          //親が変更された時、子、孫カテゴリの値を変化するため削除する。
          $('#children_category').remove(); 
          $('#grandchildren_category').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        //親カテゴリーが初期値になった時、子以下を削除する
        $('#children_category').remove(); 
        $('#grandchildren_category').remove();
      }
    });
    // 子カテゴリー選択時のイベント
    $(".field__input--category").on('change', "#children_category", function(){
      //選択された子カテゴリーの名前を取得
      var child_category = document.getElementById("children_category").value; 
      if (child_category != "選択してください"){ 
        //子カテゴリーが初期値でないことを確認
        $.ajax({
          url: 'category_grandchildren',
          type: 'GET',
          data: { child_name: child_category },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchildren_category').remove(); 
            //子が変更されると孫要素の内容も変えないといけないため孫以下を削除する
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        //子カテゴリーが初期値になった時、孫以下を削除する
        $('#grandchildren_category').remove(); 
      }
    });
  });
});




