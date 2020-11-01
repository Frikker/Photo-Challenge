# == Schema Information
#
# Table name: user_achievements
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  achievement_id :bigint           not null
#  photopost_id   :integer
#  user_id        :bigint           not null
#
# Indexes
#
#  index_user_achievements_on_achievement_id              (achievement_id)
#  index_user_achievements_on_photopost_id                (photopost_id)
#  index_user_achievements_on_user_id                     (user_id)
#  index_user_achievements_on_user_id_and_achievement_id  (user_id,achievement_id)
#
require 'test_helper'

class UserAchievementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
