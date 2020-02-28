# frozen_string_literal: true

class Photopost < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :comments
  has_many :rating
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }

  scope :custom_order, ->(order_by, order_type) {
    if order_by.blank?
      order_by = 'created_at'
      order_type = 'asc' if order_type.blank?
    end
    order(order_by => order_type)
  }

  aasm do
    state :moderating, initial: true
    state :approved
    state :banned
    state :deleted

    event :approve do
      transitions from: %i[:moderating :approved], to: :approved
    end

    event :ban do
      transitions from: %i[:moderating :approved], to: :banned
    end

    event :delete do
      transitions from: %i[:banned :approved], to: :deleted
    end

    event :restore do
      transitions from: :banned, to: :moderating
    end
  end
end
