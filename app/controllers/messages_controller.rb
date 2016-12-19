class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.new(create_params) #入力された値を保存する
    @group_id = params[:group_id]  #リダイレクトをするために、現在のページのgroup_idを取得する
    if @message.save
      redirect_to group_path(@group_id)
    else redirect_to :back, alert: 'メッセージを入力してください'

    end

  end

  private
  def create_params
    params.require(:message).permit(:message).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
