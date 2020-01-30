class Photopost < ApplicationRecord
  belongs_to :user
  has_many :rating

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 500}

  def liked?
    self.rating
  end
end
