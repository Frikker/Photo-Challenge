# frozen_string_literal: true

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
class Achievement < ApplicationRecord
  has_many :user_achievements
end
