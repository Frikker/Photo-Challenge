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
  attributes :id, :first_name, :last_name, :image, :photoposts
  attribute :urls, key: :social_link
  attribute :aasm_state, key: :status, if: :check_user

  def photoposts
    photoposts = []
    object.photoposts.all.each do |photopost|
      photoposts << { id: photopost.id, content: photopost.content, picture: photopost.picture,
                      aasm_state: (check_user ? photopost.aasm_state : nil), rating_counter: photopost.rating_count,
                      comments_counter: photopost.comments_count,
                      comments: adding_comments_info(photopost) }
    end
    photoposts
  end

  def adding_comments_info(photopost)
    comments = []
    photopost.comments.last(3).each do |comment|
      comments << { id: comment.id, content: comment.content,
                    user: { id: comment.user.id, first_name: comment.user.first_name,
                            last_name: comment.user.last_name, image: comment.user.image } }
    end
    comments
  end

  def check_user
    object.id == instance_options[:api_user] && instance_options[:template] == 'show'
  end
end
