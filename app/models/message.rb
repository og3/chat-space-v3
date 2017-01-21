class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

# imageがblankでない場合、massageがblankでは投稿できない
  validates :message, presence: true, if: ->{image.blank?}


  # キャメル型、スネーク型を注意すること
  mount_uploader :image, MessageImageUploader

end
