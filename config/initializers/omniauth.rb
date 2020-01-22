Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, '7291257', 'ttF733XSo1uFbBfXJl4N',
           callback_path: '/users/omniauth_callbacks/vkontakte',
           https: 1,
           image_size: 'original'
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end

