class User < ApplicationRecord


  def self.create_new(auth)
    create! do |user|
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.token = auth.credentials.token
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.extra.raw_info.screen_name
      user.urls = auth.info.urls.Vkontakte
      user.image = auth.info.image
    end
  end
end
