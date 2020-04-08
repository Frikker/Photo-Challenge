# == Schema Information
#
# Table name: ratings
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  photopost_id :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_ratings_on_photopost_id              (photopost_id)
#  index_ratings_on_photopost_id_and_user_id  (photopost_id,user_id)
#  index_ratings_on_user_id                   (user_id)
#

require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
