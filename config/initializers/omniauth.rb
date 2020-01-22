Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, '7290933', 'zpmquqgXJJZhEQr9s9AO',
           callback_path: '/users/omniauth_callbacks/vkontakte',
           https: 1,
           image_size: 'original'
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end

