Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['VKONTAKTE_KEY'], ENV['VKONTAKTE_SECRET'],
           https: 1,
           image_size: 'original'
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end

