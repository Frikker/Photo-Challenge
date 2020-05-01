# frozen_string_literal: true

class PhotopostSerializer < ActiveModel::Serializer
  attributes :id, :content, :picture, :user_id

  belongs_to :user
end
