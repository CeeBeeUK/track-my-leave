module OmniAuthHelpers
  def setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        name: 'John Doe',
        email: 'john@company_name.com',
        first_name: 'John',
        last_name: 'Doe',
        image: 'https://lh3.googleusercontent.com/url/photo.jpg'
      },
      credentials: {
        token: '',
        expires_at: Time.zone.now + 1.month
      },
      extra: {
        id_info: {
          hd: hd
        }
      }
    )
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end
end

RSpec.configure do |c|
  c.include OmniAuthHelpers, type: :controller
end
