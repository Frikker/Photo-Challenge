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
class PhotopostSerializer < ActiveModel::Serializer
  attributes :id, :content, :picture, :comments_count, :rating_count

  belongs_to :user
  has_many :rating do
    rating = []
    object.rating.each do |like|
      rating << { id: like.id, user: { id: like.user.id, first_name: like.user.first_name,
                                       last_name: like.user.last_name, image: like.user.image } }
    end
    rating
  end
  has_many :comments do
    comments = []
    object.comments.each do |comment|
      comments << { id: comment.id, content: comment.content, user: { id: comment.user.id,
                                                                      first_name: comment.user.first_name,
                                                                      last_name: comment.user.last_name,
                                                                      image: comment.user.image } }
    end
    comments
  end
end
