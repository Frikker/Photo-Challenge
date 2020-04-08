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

class User < ApplicationRecord
  has_many :photoposts, dependent: :destroy
  has_many :comments
  has_many :ratings, dependent: :destroy

end
