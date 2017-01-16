class UsersController < ApplicationController

  def index
    # users_tableから曖昧検索をして変数usersに入れる やり方は、where("カラム名 like '%検索テキスト%'")
    @users = User.where('name like ?', "%#{params[:name]}%")
    # json形式で値を返す
    render json: @users
  end
end
