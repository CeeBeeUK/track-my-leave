OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    scope: 'email, profile, openid',
    prompt: 'select_account',
    access_type: 'online',
    image_aspect_ratio: 'square',
    image_size: 25
end
