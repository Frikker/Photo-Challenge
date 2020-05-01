class RatingSerializer < ActiveModel::Serializer
  attributes :id, :photopost_id, :user_id
end
