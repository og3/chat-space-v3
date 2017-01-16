$(function() {
// 1, #chat-group_userにワードが入力された時の処理
  $("#chat-group_user").on("keyup", function() {
   // 変数inputに、#chat-group_userに入力された値を取得し、代入する
    var input = $("#chat-group_user").val();
    // 検索結果が表示される#user-search-resultの部分を空にする
    $("#user-search-result").empty();
    // 変数inputに値が入力されて、かつ文字数が0でない時に発動 値をJSON形式でGETのリクエストを飛ばす
    if (input.length !== 0) {
      // すべてのユーザー名を取得するためにusers_controllerのindexにリクエストを飛ばす
      $.ajax({
        type: 'GET',
        url: '/users.json',
        // data: {カラム名: 入力された値（今回は変数）} 入力された値に対応した値をカラムから取ってくる
        data: { name: input },
        dataType: 'json'
      })
      // 非同期通信が成功した場合の処理
      .done(function(data) {
        // 入力された値に対応するユーザー名を探すためにsearchUserに上で取得したdataの配列を送る
        search_user(data);
      });
    }
  });

// 2, 1の処理で送られたdata配列の中身をeachで取り出してaddUserに送る
    function search_user(users){
      // .empty()で前回の検索結果があった場合削除する
      $("#user-search-result").empty();
      $.each(users, function(i, user){
        add_user(user);
      })
    }

// 3 ,入力された値に応じてユーザー情報の表示する処理
  function add_user(data){
    // 2の処理で送られた入力された値に対応するユーザー名の入った変数userから、name,idをとって表示する。また「追加」ボタンを作成する。
    var html =
      '<div class="chat-group-user clearfix">'                                                     +
        '<p class="chat-group-user__name">'                                                        +
          data.name                                                                                +
        '</p>'                                                                                     +
        '<a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="' + data.id + '" data-user-name="' + data.name + '">追加'                                                                                         +
        '</a>'                                                                                     +
      '</div>';
      // 表示する内容は#user-search-resultの場所に行う
      $("#user-search-result").append(html);
      // クリックした後の処理を実行するために関数をここで宣言する。
      get_user();
    }

// 4,「追加ボタン」が押されたユーザー情報を取得する処理
    function get_user(){
      //  3で表示された「追加」ボタンをクリックすると発動する
      $(".chat-group-user__btn--add").on('click', function(e){
        e.preventDefault();
        // thisでクリックされた場所のid,nameを変数に代入する
        var user_id = $(this).data("user-id");
        var user_name = $(this).data("user-name");
        // .parent()でクリックされた部分の子要素を選択し、変数userに代入する
        var user = $(this).parent();
        // 「追加する」をクリックした場合、クリックされたユーザーの情報を消すために変数userを削除する
        user.remove();
        // クリックされたユーザーをグループに追加する処理に、取得したユーザーのnameとidを送る
        add_user_to_group(user_id, user_name);
      });
    }

// 5, 4から送られたユーザーをグループに追加する処理
    function add_user_to_group(id, name){
      // 追加されたユーザーをグループメンバー一覧に表示するためのhtmlを作成
      console.log(id);
      var appended_user_html =
       '<div class="chat-group-user  clearfix">'                                           +
        '<input name="group[user_ids][]" type="hidden"' + 'value=' + id + '>'   +
        '<p class="chat-group-user__name">'                                     +
          name                                                                  +
        '</p>'                                                                  +
        '<a class="user-search-remove ' + 'chat-group-user__btn chat-group-user__btn--remove"' + 'data-user-id=' + id + '>削除'                                          +
        '</a>'                                                                  +
      '</div>';
      // #chat-group-usersにappended_user_htmlを追加
      $("#chat-group-users").append(appended_user_html);
      delete_user();
    }

// 6, 5で追加されたユーザーを削除する
    function delete_user(){
      $("#chat-group-users").on('click','.chat-group-user',function(){
        $(this).remove();
      })
    }
  });
