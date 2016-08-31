require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create :user }
  let(:hd) { 'digital.justice.gov.uk' }
  describe '#create' do
    before do
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
        extra: {
          id_info: {
            hd: hd
          }
        }
      )
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end
    context 'when a user exists' do

      subject { response }

      before do
        allow(User).to receive(:from_omniauth).and_return(user)
        get :create
      end

      it { is_expected.to have_http_status :redirect }
      it { is_expected.to redirect_to :root}

      it 'does not display a flash alert' do
        expect(flash[:alert]).to_not be_present
      end
    end

    context 'when the user is in the wrong domain' do
      let(:hd) { 'personal.gmail' }

      subject { response }

      before do
        get :create
      end

      it { is_expected.to have_http_status :redirect }
      it { is_expected.to redirect_to :root}

      it 'displays a flash alert' do
        expect(flash[:alert]).to be_present
        expect(flash[:alert]).to eql('The system is only available to MoJ Digital staff using a google mail account')
      end
    end

  end
end
