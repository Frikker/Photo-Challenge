class Photopost < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :rating
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }

  scope :custom_order, ->(order_by, ordering) {
    order(order_by => ordering)
  }
end
