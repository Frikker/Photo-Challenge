# frozen_string_literal: true

module Users
  class Create < ActiveInteraction::Base
    hash :auth,
         strip: false
    string :provider
    object :user,
           class: User

    def execute
      user = if provider == 'vkontakte'
               User.create!(uid: auth[uid],
                            first_name: auth[info][first_name],
                            last_name: auth[info][last_name],
                            token: auth[credentials][token],
                            provider: auth[provider],
                            nickname: auth[extra][raw_info][screen_name],
                            urls: auth[info][urls][Vkontakte],
                            image: auth[info][image])
             elsif provider == 'facebook'
               User.create!(first_name: name[0],
                            last_name: name[1],
                            token: auth.credentials.token,
                            provider: auth.provider,
                            uid: auth.uid,
                            nickname: auth.extra.raw_info.username,
                            urls: auth.extra.raw_info.link,
                            image: auth.info.image)
             end
      user
    end
  end
end