# frozen_string_literal: true

module PhotopostsHelper
  def check_likes(photopost)
    !photopost.rating.find_by(user_id: current_user).nil?
  end
end