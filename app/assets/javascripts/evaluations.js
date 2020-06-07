$(function(){
  $("#evaluation__btn").click(function(e){
    e.preventDefault();
    let flag = false
    $('input:required').each(function(e) {
      if ($('input:required').eq(e).prop('checked')) {
        flag = true;
      }
    });
    if (flag){
      Rails.fire($("#evaluation__form")[0], 'submit');
    }else{
      const errorBox = $(".content__trading__nav")
      const next     = errorBox.next();
      if (!next.hasClass("radio-error-class")){
        errorBox.after(`<div class=radio-error-class>評価を選択してください</div>`);
      }
      $(this).off('submit');
      $('body,html').animate({ scrollTop: 0 }, 500);
      return false;
    }
  })
})

