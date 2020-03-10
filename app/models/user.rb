class User < ApplicationRecord
  has_many :photoposts, dependent: :destroy
  has_many :comments
  has_many :ratings, dependent: :destroy

end
