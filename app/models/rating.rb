class Rating < ApplicationRecord
  belongs_to :photopost, counter_cache: :rating_count
  belongs_to :user
end
