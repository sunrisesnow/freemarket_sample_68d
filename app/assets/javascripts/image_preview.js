$(document).on('turbolinks:load', function () {
  $(function () {
    function buildHTML(icon_image) {
      var html =
        `
        <div class="member-main__image">
          <img src="${icon_image}", alt="preview" class="image-perv">
        </div>
        `
      return html;
    }

    // 画像が選択された時に発火します
    $(document).on('change', '.hidden_file', function () {
      // .file_filedからデータを取得して変数fileに代入します
      var file = this.files[0];
      // FileReaderオブジェクトを作成します
      var reader = new FileReader();
      // DataURIScheme文字列を取得します
      reader.readAsDataURL(file);
      // 読み込みが完了したら処理が実行されます
      reader.onload = function () {
        // 読み込んだファイルの内容を取得して変数imageに代入します
        var icon_image = this.result;
        // プレビュー画像がなければ処理を実行します
        if ($('.member-main__image-read').length == 0) {
          // 読み込んだ画像ファイルをbuildHTMLに渡します
          var html = buildHTML(icon_image)
          //var image_url = $(".member-main__image")[0].children[0].src
          // 作成した.member-main__image-readをiconの代わりに表示させます
          $('.member-main__image').prepend(html);
          // 画像が表示されるのでiconを隠します
          $('.no-name').hide();
        } 
      }
    });
  });
});