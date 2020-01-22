class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def self.find_or_create_user_by_vk_oauth(access_token)
    if self == User.where(url: access_token.info.urls.Vkontakte).first
      self
    else
      User.create(provider: access_token.provider,
                  url: access_token.info.urls.Vkontakte,
                  first_name: access_token.info.first_name,
                  last_name: access_token.info.last_name,
                  nickname: access_token.extra.raw_info.screen_name + '@vk.com',
                  token: access_token.credential.token,
                  password: Devise.friendly_token[0, 20])
    end
  end

  def self.find_or_create_user_by_fb_oauth(access_token)
    if self == User.where(url: access_token.info.urls.Vkontakte).first
      self
    else
      User.create(provider: access_token.provider,
                  url: access_token.info.urls.Vkontakte,
                  first_name: access_token.info.first_name,
                  last_name: access_token.info.last_name,
                  nickname: access_token.info.username,
                  email: access_token.info.email,
                  token: access_token.credentials.token,
                  password: Devise.friendly_token[0, 20])
    end
  end
end
