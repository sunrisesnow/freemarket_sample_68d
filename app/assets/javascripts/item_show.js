$(function() {
  const slider = "#slider_images";
  const sliderImages = "#slider_images .slider_image"
  const thumbnailImages = "#thumb_images .thumb_image";
  let image_index;
  let index;

  // 画像にindexを振る
  $(thumbnailImages).each(function() {
    image_index = $(thumbnailImages).index(this);
    if (image_index == 0) {
      $(this).addClass("thumbnail-current")
    }
    $(this).attr("data-index", image_index);
  });

  // 画像のindexをもとに、サムネイルで選択中の画像にクラスを付与
  $(slider).on('init', function(slick) {
    index = $(".slide-item.slick-slide.slick-current").attr("data-slick-index");
    $(thumbnailImages+'[data-index="'+index+'"]').addClass("thumbnail-current");
   });
 
  //slickスライダー定義
  $(slider).slick({
    prevArrow:'<i class="fa fa-angle-left arrow arrow-left"></i>',
    nextArrow:'<i class="fa fa-angle-right arrow arrow-right"></i>',
    fade: true,
    infinite: true,
  });

  //サムネイル画像アイテムをクリックしたときにスライダー切り替え
  $(thumbnailImages).on('click', function(){
    index = $(this).attr("data-index");
    $(slider).slick("slickGoTo",index,false);
  });

  //サムネイル画像のクラスを切り替え
  $(slider).on('beforeChange',function(event, slick, currentSlide, nextSlide){
    $(thumbnailImages).each(function(){
      $(this).removeClass("thumbnail-current");
    });
    $(thumbnailImages+'[data-index="'+nextSlide+'"]').addClass("thumbnail-current");
  });
});
