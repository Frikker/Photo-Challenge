# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  parent_id    :bigint
#  photopost_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_comments_on_parent_id                               (parent_id)
#  index_comments_on_photopost_id                            (photopost_id)
#  index_comments_on_user_id                                 (user_id)
#  index_comments_on_user_id_and_parent_id_and_photopost_id  (user_id,parent_id,photopost_id)
#
# Foreign Keys
#
#  fk_rails_...  (photopost_id => photoposts.id)
#  fk_rails_...  (user_id => users.id)
#
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user

  belongs_to :photopost
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :image
  end
end
