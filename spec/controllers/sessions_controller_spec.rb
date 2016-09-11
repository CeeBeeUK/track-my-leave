require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create :user }

  subject { response }

  describe '#create' do
    before do
      allow(User).to receive(:from_omniauth).and_return(omniauth_returns)
      setup
      get :create
    end

    context 'when the applicant is in the correct domain' do
      let(:omniauth_returns) { user }

      it { is_expected.to have_http_status :redirect }
      it { is_expected.to redirect_to :root }

      it 'does not display a flash alert' do
        expect(flash[:alert]).not_to be_present
      end
    end

    context 'when the applicant is in the wrong domain' do
      let(:omniauth_returns) { nil }

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
