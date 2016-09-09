require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create :user }

  subject { response }

  describe '#show' do
    before do
      session[:user_id] = user_id
      get :show
    end

    context 'when a user is logged in' do
      let(:user_id) { user.id }
      it { is_expected.to have_http_status :success }
    end

    context 'when a user is not logged in' do
      let(:user_id) { nil }
      it { is_expected.to have_http_status :redirect }
      it { is_expected.to redirect_to :login }
    end
  end
end
