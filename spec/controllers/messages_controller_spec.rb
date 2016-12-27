require 'rails_helper'

describe MessagesController do

  let(:group) { create(:group) }

  describe 'GET #index' do
    #indexの値が正確かどうか
    it "assigns the requested contact to messages" do
      messages = create_list(:message, 3, group_id: group.id)
      get :index, group_id: group.id #set_groupを動かす際にgroup.idが必要。
      expect(assigns(:messages)).to match(messages)
    end
    #indexのviewに飛べるかどうか
    it "renders the :index template" do
      get :index, group_id: group.id
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    # userをFactoryGirlで作る
    let(:user) { create(:user) }
    # 作ったユーザでログインする
    before do
      sign_in user
    end

    #createアクションで投稿を保存できた場合
    it "success to save" do
      get :index, group_id: group.id
      expect {
        post :create, group_id: group.id, message: attributes_for(:message)
      }.to change(Message, :count).by(1)
    end
    #createアクションで投稿を保存できなかった場合
    it "failure to save" do
      get :index, group_id: group.id
      expect {
        post :create, group_id: group.id, message: attributes_for(:message, message: "")
      }.not_to change(Message, :count)
    end
    #createアクションの後でindexアクションにリダイレクトできるかどうか
    it "redirects to messages#index" do
      post :create, group_id: group.id, message: attributes_for(:message)
      expect(response).to redirect_to group_messages_path
    end
  end
end
