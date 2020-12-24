# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, '7291257', '9sOdVLVU64Z9SQyyJRWh',
           callback_path: '/auth/vkontakte/callback',
           https: 1,
           scope: %w[email photos offline wall],
           image_size: 'original'
  provider :facebook, '821656748409519', '330f0795edc63b02e26b4f0c1f98dd2a',
           scope: 'email,user_photos,public_profile'
end
