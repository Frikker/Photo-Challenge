# frozen_string_literal: true

# == Schema Information
#
# Table name: photoposts
#
#  id             :bigint           not null, primary key
#  aasm_state     :string
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
  attributes :id, :content, :picture, :user_id

  belongs_to :user
end
