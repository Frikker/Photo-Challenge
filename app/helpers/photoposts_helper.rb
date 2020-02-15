module PhotopostsHelper
  def check_likes(photopost)
    likes = photopost.rating
    if likes.nil?
      false
    else
      likes.find_by(user_id: current_user)
    end
  end
end
