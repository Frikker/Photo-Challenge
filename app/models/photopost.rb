class Photopost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(likes: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }

end
