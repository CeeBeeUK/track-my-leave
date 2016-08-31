require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create :user }

  subject { response }

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
      get :create
    end

    context 'when the applicant is in the correct domain' do
      let(:hd) { 'digital.justice.gov.uk' }

      before { allow(User).to receive(:from_omniauth).and_return(user) }

      it { is_expected.to have_http_status :redirect }
      it { is_expected.to redirect_to :root }
      it 'does not display a flash alert' do
        expect(flash[:alert]).not_to be_present
      end
    end

    context 'when the applicant is in the wrong domain' do
      let(:hd) { nil }
      it { is_expected.to have_http_status :redirect }
      it { is_expected.to redirect_to :root }
      it 'displays a flash alert' do
        expect(flash[:alert]).to be_present
        expect(flash[:alert]).to eql('The system is only available to MoJ Digital staff using a google mail account')
      end
    end
  end

  describe '#destroy' do
    before { get :destroy }
    it { is_expected.to have_http_status :redirect }
    it { is_expected.to redirect_to :root }
  end
end
