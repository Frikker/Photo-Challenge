# frozen_string_literal: true

module PhotopostsHelper
  def check_likes(photopost)
    !photopost.rating.find_by(user_id: current_user).nil?
  end

  def likes_icon
    if check_likes(photopost)

    end
  end

  def like_method

  end

  def authenticity_token
    current_user.authenticity_token unless current_user.nil?
  end
end