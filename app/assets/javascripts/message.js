$(function() {
  function buildHTML(adddata) {
// 新規に入力された値を入れるhtmlを新規に作る。記法はHTMLで書く。
    var html =
      '<li class="chat__main__body__chat__set">'              +
        '<p class="chat__main__body__chat__set__name">'       +
          adddata.name                                        +
        '</p>'                                                +
        '<p class="chat__main__body__chat__set__time_stamp">' +
          adddata.datetime                                    +
        '</p>'                                                +
        '<p class="chat__main__body__chat__set__message">'    +
          adddata.message                                     +
        '</p>'                                                +
      '</li>'
    return html;
  }

//sendボタンがclickされた時に以下のイベントが行われるようにする。（メッセージ送信後にsendボタンにdisabledがかからないようにするため）
  $('.chat__main__footer__send_button').click('submit', function(e) {
//フォームが送信された時に、デフォルトだとフォームを送信するための通信がされてしまうので、preventDefault()を使用してデフォルトのイベントを止める
    e.preventDefault(); 
    var $textField = $('.js-message-form__text-area'); //class js-form__text-fieldを代入
    var message = $textField.val(); //js-form__text-fieldのフォームに入力された値を取得し、messageに代入
    $.ajax({
      url: window.location.href,
      type: 'POST',
      data: {
        message: {
          message: message //二重ハッシュ構造 messageハッシュの中にmessageキーとmessageバリューが入っている。messageの名前にしてるのはコントローラーのストロングパラメータに対応させるため。
        }
      },
      dataType: 'json' //データをjson形式でリクエストする
    })
    //↓フォームの送信に成功した場合の処理
    .done(function(data) {
      var html = buildHTML(data);
      //ul.chat__main__body__chatを選択し、上の変数htmlを挿入している
      $('ul.chat__main__body__chat').append(html); 
      // textfieldを空にする
      $textField.val('');
    })
    //↓フォームの送信に失敗した場合の処理
    .fail(function() {
      alert('error');
    });
  });
});
