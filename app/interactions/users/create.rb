# frozen_string_literal: true

module Users
  class CreateUser < ActiveInteraction::Base
    hash :auth,
         strip: false
    string :provider

    def to_model
      User.new
    end

    def execute
      user = User.new
      if provider == 'vkontakte'
        user.uid = auth[uid]
        user.first_name = auth[info][first_name]
        user.last_name = auth[info][last_name]
        user.token = auth[credentials][token]
        user.provider = auth[provider]
        user.nickname = auth[extra][raw_info][screen_name]
        user.urls = auth[info][urls][Vkontakte]
        user.image = auth[info][image]
      elsif provider == 'facebook'
        user.first_name = name[0]
        user.last_name = name[1]
        user.token = auth.credentials.token
        user.provider = auth.provider
        user.uid = auth.uid
        user.nickname = auth.extra.raw_info.username
        user.urls = auth.extra.raw_info.link
        user.image = auth.info.image
      end

      errors.merge!(user.errors) unless user.save

      user
    end
  end
end