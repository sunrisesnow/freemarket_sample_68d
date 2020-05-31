$(window).scroll(function (){
  $('.pickup-box').each(function(){
    var position = $(this).offset().top;
    var scroll = $(window).scrollTop();
    var windowHeight = $(window).height();
    if (scroll > position - windowHeight + 100){
      $(this).addClass('active');
    }
  });
});
$(function(){
  $("#message-send-btn").on('click', function(){
    $('#trading__messages').animate({ scrollTop: $('#trading__messages')[0].scrollHeight});
  })
})