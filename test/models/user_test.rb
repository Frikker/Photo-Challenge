# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  first_name :string
#  image      :string
#  last_name  :string
#  nickname   :string
#  provider   :string
#  token      :string
#  uid        :string
#  urls       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_token  (token)
#  index_users_on_uid    (uid)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
