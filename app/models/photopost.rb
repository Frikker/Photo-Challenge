class Photopost < ApplicationRecord
  belongs_to :user
  has_one :rating

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 500}
end
