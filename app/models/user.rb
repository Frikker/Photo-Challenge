# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  aasm_state         :string
#  authenticity_token :string
#  ban_reason         :string
#  first_name         :string
#  image              :string
#  last_name          :string
#  nickname           :string
#  provider           :string
#  token              :string
#  uid                :string
#  urls               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_authenticity_token  (authenticity_token) UNIQUE
#  index_users_on_token               (token)
#  index_users_on_uid                 (uid)
#

class User < ApplicationRecord
  include AASM

  has_many :photoposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :user_achievements, dependent: :destroy

  mount_uploader :image, PictureUploader

  has_secure_token :authenticity_token

  aasm do
    state :active
    state :passive, initial: true
    state :banned
    state :reported

    event :ban do
      transitions from: %i[active passive reported], to: :banned
      after do
        ban_photoposts
      end
    end

    event :restore do
      before do
        self.ban_reason = ''
      end
      transitions from: %i[passive reported banned], to: :active
      after do
        photoposts.each(&:moderate!)
      end
    end

    event :report do
      transitions from: %i[active passive banned], to: :reported
    end
  end

  def ban_photoposts
    photoposts.each do |post|
      if post.banned?
        post.destroy!
      else
        post.ban_reason = 'User ban'
        post.ban!
      end
    end
    ratings.delete_all
    comments.delete_all
    user_achievements.delete_all
  end
end
