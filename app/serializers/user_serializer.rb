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
class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :image
  attribute :urls, key: :social_link

  has_many :photoposts do
    photoposts = []
    object.photoposts.each do |post|
      photoposts << { id: post.id, content: post.content, picture: post.picture,
                      comment_counter: post.comments_count, rating_counter: post.rating_count }
    end
    photoposts
  end
end
