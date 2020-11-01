# frozen_string_literal: true

# == Schema Information
#
# Table name: photoposts
#
#  id             :bigint           not null, primary key
#  aasm_state     :string
#  ban_reason     :string
#  comments_count :integer          default(0)
#  content        :text
#  picture        :string
#  rating_count   :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_photoposts_on_user_id                 (user_id)
#  index_photoposts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Photopost < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :rating, dependent: :destroy
  has_many :user_achievements

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  validates :picture, presence: true

  scope :custom_order, lambda { |order_by = 'created_at', order_type = 'asc'|
    if order_by.blank?
      order_by = 'created_at'
      order_type = 'asc' if order_type.blank?
    end
    where(aasm_state: :approved).order(order_by => order_type)
  }

  scope :user_search, lambda { |search_by, value|
    joins(:user).where("lower(users.#{search_by}) LIKE '%#{value}%'")
  }

  scope :post_search, lambda { |search_by, value|
    where("lower(#{search_by}) LIKE '%#{value}%'")
  }

  aasm do
    state :moderating, initial: true
    state :approved
    state :banned

    after_all_transitions :change_user_status

    event :approve do
      transitions from: %i[moderating banned], to: :approved
    end

    event :ban do
      transitions from: %i[moderating approved], to: :banned
    end
  end

  private

  def check_photoposts
    Photopost.where(user_id: user_id, aasm_state: 'banned').all.count >= 4
  end

  def change_user_status
    user = User.find(user_id)
    if check_photoposts && !user.banned?
      user.ban_reason = 'You have 4 or more banned posts'
      user.ban!
    elsif user.banned?
      user.ban_reason = ''
      if ReportReason.where(user_id: user.id).any?
        user.report!
      else
        user.restore!
      end
    end
  end
end
