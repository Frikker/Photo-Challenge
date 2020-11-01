# == Schema Information
#
# Table name: achievements
#
#  id          :bigint           not null, primary key
#  description :string
#  medal       :string
#  name        :string
#  points      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class AchievementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
