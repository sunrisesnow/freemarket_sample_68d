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
    $(this).css("background-color", "#3ccace").css("color", "white");
  }).mouseout(function(){
    $(this).css("background-color", "white").css("color", "black");
  });

  // 子要素にmouseoverした時、子要素、子要素の親要素css変化（mouseoverした時も変化）
  $('.category__child--name').mouseover(function(){
    let parent = $(this).parent().parent().parent().children('a');
    $(this).css("background-color", "lightgray");
    parent.css("background-color", "#3ccace").css("color", "white");
  }).mouseout(function(){
    let parent = $(this).parent().parent().parent().children('a');
    $(this).css("background-color", "white");
    parent.css("background-color", "white").css("color", "black");
  });

  // 孫要素にmouseoverした時、孫要素、孫要素の親要素、孫要素の祖先要素css変化（mouseoverした時も変化）

  $('.category__grandchild--name').mouseover(function(){
    let child  = $(this).parent().parent().parent().children('a');
    let parent = child.parent().parent().parent().children('a');
    $(this).css("background-color", "lightgray");
    child.css("background-color", "lightgray");
    parent.css("background-color", "#3ccace").css("color", "white");
  }).mouseout(function(){
    let child  = $(this).parent().parent().parent().children('a');
    let parent = child.parent().parent().parent().children('a');
    $(this).css("background-color", "white");
    child.css("background-color", "white");
    parent.css("background-color", "white").css("color", "black");
  });
});




