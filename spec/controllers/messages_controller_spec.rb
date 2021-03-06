require 'rails_helper'

describe MessagesController do

    # user,groupをFactoryGirlで作る
    let(:user) { create(:user) }
    let(:group) { create(:group) }
    # 作ったユーザでログインする
    before do
      sign_in user
    end

    before do
      get :index, group_id: group.id
    end

  describe 'GET #index' do
    #indexの値が正確かどうか
    it "assigns the requested contact to messages" do
      messages = create_list(:message, 3, group_id: group.id)
      expect(assigns(:messages)).to match(messages)
    end
    #indexのviewに飛べるかどうか
    it "renders the :index template" do
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    #createアクションで投稿を保存できた場合
    it "success to save" do
      expect {
        post :create, group_id: group.id, message: attributes_for(:message)
      }.to change(Message, :count).by(1)
    end
    #createアクションで投稿を保存できなかった場合
    it "failure to save" do
      expect {
        post :create, group_id: group.id, message: attributes_for(:message, message: "")
      }.not_to change(Message, :count)
    end
    #saveに成功した後でindexアクションにリダイレクトできるかどうか
    it "success to save message and redirects to messages#index" do
      post :create, group_id: group.id, message: attributes_for(:message)
      expect(response).to redirect_to group_messages_path
    end
    #saveに失敗した後でindexアクションにリダイレクトできるかどうか
    it "failure to save message and redirects to messages#index" do
      post :create, group_id: group.id, message: attributes_for(:message, message: "")
      expect(response).to redirect_to group_messages_path
    end
  end
end
