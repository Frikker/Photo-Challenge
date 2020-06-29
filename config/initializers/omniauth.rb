# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, '7291257', '9sOdVLVU64Z9SQyyJRWh',
           callback_path: '/auth/vkontakte/callback',
           https: 1,
           scope: %w[email photos offline wall],
           image_size: 'original'
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           scope: 'email,user_photos,public_profile'
end