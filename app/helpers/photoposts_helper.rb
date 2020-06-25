# frozen_string_literal: true

module PhotopostsHelper
  def check_likes(photopost)
    !photopost.rating.find_by(user_id: current_user).nil?
  end

  def authenticity_token
    current_user.authenticity_token unless current_user.nil?
  end

  class Vkontakte
    include HTTParty
    base_uri 'api.vk.com'

    def initialize(user)
      @options = { query: api_params(user) }
    end

    def vk_photos
      self.class.get('/method/photos.getAll?', @options)
    end

    private

    def api_params(current_user)
      { count: 15, owner_id: current_user.uid,
        access_token: current_user.token,
        v: '5.110' }
    end
  end
end