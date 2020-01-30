class Rating < ApplicationRecord
  belongs_to :photopost
  belongs_to :user
end
