class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photopost, dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true

  validates :user_id, presence: true
  validates :photopost_id, presence: true
end
