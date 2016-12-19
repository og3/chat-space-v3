class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = Group.find(params[:group_id]) #グループのページにアクセスした時に、そのグループの番号を受け取る
    @messages = @group.messages #上で受け取ったグループの番号に関連したmessageテーブルの値を取得する
    @groups = current_user.groups #ログイン中のユーザーが属するグループの情報を持ってくる
    @message = Message.new #form_forに入力される値を受け取るための箱を用意する
  end

  def create
    @message = Message.new(create_params) #入力された値を保存する
    @group_id = params[:group_id]  #リダイレクトをするために、現在のページのgroup_idを取得する
    if @message.save
      redirect_to group_messages_path(@group_id)
    else redirect_to :back, alert: 'メッセージを入力してください'

    end

  end

  private
  def create_params
    params.require(:message).permit(:message).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
