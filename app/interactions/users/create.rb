# frozen_string_literal: true

module Users
  class Create < ActiveInteraction::Base
    hash :auth,
         strip: false
    string :provider

    def execute
      user = User.new
      user.authenticity_token = create_auth_token
      send "#{provider}_user", user
      errors.merge!(user.errors) unless user.save
      user
    end

    private

    def vkontakte_user(user)
      user.uid = auth['uid']
      user.first_name = auth['info']['first_name']
      user.last_name = auth['info']['last_name']
      user.token = auth['credentials']['token']
      user.provider = auth['provider']
      user.nickname = auth['extra']['raw_info']['screen_name']
      user.urls = auth['info']['urls']['Vkontakte']
      user.remote_image_url = auth['info']['image']
    end

    def facebook_user(user)
      user.first_name = name[0]
      user.last_name = name[1]
      user.token = auth['credentials']['token']
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.nickname = auth['extra']['raw_info']['username']
      user.urls = auth['extra']['raw_info']['link']
      user.remote_image_url = auth['info']['image']
    end

    def create_auth_token
      SecureRandom.hex(10)
    end
  end
end
