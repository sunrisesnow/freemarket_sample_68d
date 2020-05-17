//$(function()  {
  // タブのDOM要素を取得し、変数で定義
  //let tabs = $(".mypage-tabs");

  // クラスの切り替えをtabSwitch関数で定義
  //function tabSwitch() {
    // 全てのactiveクラスのうち、最初の要素を削除（"[0]は、最初の要素の意味"）
    //$(".active").removeClass("active");

    // クリックしたタブにactiveクラスを追加

    //$(this).addClass("active");
    
    // 何番目の要素がクリックされたかを、配列tabsから要素番号を取得
    //const index = tabs.index(this);

    // クリックしたタブに対応するshowクラスを追加する
    //$(".mypage-tabs-left-contents-messages").removeClass("show").eq(index).addClass("show");
  //}

  // タブがクリックされたらtabSwitch関数を呼び出す
  //tabs.click(tabSwitch);
//});

let leftTabs = $(".mypage-tabs-left");

  leftTabs.click(tabSwitch);

function lefttabSwitch( ){　

  $(".active").removeClass("active");

  $(this).addClass("active");

  const index = tabs.index(this);

  // クリックしたタブに対応するshowクラスを追加する
  $(".mypage-tabs-left-contents-messages").removeClass("show").eq(index).addClass("show");

  $($(this).attr('href')).fadeToggle(800);
// タブがクリックされたらtabSwitch関数を呼び出す
  tabs.click(lefttabSwitch);
}



let rightTabs = $(".mypage-tabs-right");

  rightTabs.click(rightTabSwich)

function rightTabSwitch(){

  $(".active").removeClass("active");

  // クリックしたタブにactiveクラスを追加

  $(this).addClass("active");
  

  // 何番目の要素がクリックされたかを、配列tabsから要素番号を取得
  const index = tabs.index(this);

  // クリックしたタブに対応するshowクラスを追加する
  $(".mypage-tabs-right-contents-messages").removeClass("show").eq(index).addClass("show");


// タブがクリックされたらtabSwitch関数を呼び出す
  tabs.click(righttabSwitch);
}
