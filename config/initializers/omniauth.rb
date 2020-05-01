# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['VKONTAKTE_KEY'], ENV['VKONTAKTE_SECRET'],
           callback_path: '/auth/vkontakte/callback',
           https: 1,
           scope: 'photos',
           image_size: 'original'
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           scope: 'email,user_photos,public_profile'
end