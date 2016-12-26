require 'rails_helper'

describe Message do #Messageモデルのテストであることの宣言
  describe '#create' do
    it "is invalid without a message" do #messageが空だった場合無効になる
      message = build(:message, message: "")
      message.valid?
      expect(message.errors[:message]).to include("を入力してください。")
    end

    it "is valid with a message" do #messageが存在していたら投稿できる
      user = create(:user)
      group = create(:group)
      message = build(:message, user_id: user.id, group_id: group.id)
      expect(message).to be_valid #be_validはexpectの引数にしたインスタンスが全てのバリデーションをクリアする場合にパスするマッチャ
    end
  end
end
