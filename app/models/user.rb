class User < ApplicationRecord
  has_many :photoposts, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  def self.create_new(auth, provider)
    case provider
    when 'vkontakte'
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
    when 'facebook'
      create! do |user|
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.token = auth.credentials.token
        user.provider = auth.provider
        user.uid = auth.uid
        user.nickname = auth.extra.raw_info.username
        user.urls = auth.extra.raw_info.link
        user.image = auth.info.image
      end
    end
  end
end
