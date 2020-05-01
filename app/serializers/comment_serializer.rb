# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :parent_id, :photopost_id, :content

  belongs_to :photopost
  belongs_to :user
  belongs_to :comment, class_name: 'Comment', optional: true
end
