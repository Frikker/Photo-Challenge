module RatingsHelper

  def user_likes(user_id)
    Rating.where(user_id: user_id).all.count
  end

end
