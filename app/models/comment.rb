class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photopost, dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true

  validates_presence_of :user_id, :photopost_id
end
