class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only:[:index]

  def index
    @messages = @group.messages #上で受け取ったグループの番号に関連したmessageテーブルの値を取得する
    @message = Message.new #form_forに入力される値を受け取るための箱を用意する
  end

  def create #ここでの変数はviewでは使うことがないので、ローカル変数にする
    message = Message.new(create_params) #入力された値を保存する
    if message.save
      redirect_to group_messages_path(params[:group_id]) #アドレスに入力されているgroup_idのページにリダイレクトする
    else 
      redirect_to :back, alert: 'メッセージを入力してください'
    end

  end

  private
  def create_params
    params.require(:message).permit(:message).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def set_group
    @group = Group.find(params[:group_id]) #グループのページにアクセスした時に、そのグループの番号を受け取る
  end
end
