$(function(){
  $(document).on('change', '#account_icon_image', function () {
    const file = this.files[0];
    const fileReader = new FileReader();
    fileReader.readAsDataURL(file);
    fileReader.onload = function () {
      const image = this.result;
      $('.account__image__form__icon').attr({ src: image });
      $('.user__mypage--icon').attr({ src: image });
      $('.user__mypage--big--icon').attr({ src: image });
    }
  });
  $(document).on('change',  '#account_background_image', function () {
    const file = this.files[0];
    const fileReader = new FileReader();
    fileReader.readAsDataURL(file);
    fileReader.onload = function () {
      const image = this.result;
      $('.account__image__form__background').attr({ src: image });
      $('.mypage__background').attr({ src: image });
    }
  });
});

$(function() {
  const notif_tab = $('#notif_tab')
  const notif_tab_box =$('#notif_tab_box')
  const todo_tab = $('#todo_tab')
  const todo_tab_box = $('#todo_tab_box')

  notif_tab.on('click', function() {
    notif_tab.addClass('active_tab')
    notif_tab_box.addClass('active_box')
    todo_tab.removeClass('active_tab')
    todo_tab_box.removeClass('active_box')
  });

  todo_tab.on('click', function() {
    todo_tab.addClass('active_tab')
    todo_tab_box.addClass('active_box')
    notif_tab.removeClass('active_tab')
    notif_tab_box.removeClass('active_box')
  });

});