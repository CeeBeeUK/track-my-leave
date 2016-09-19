require 'rails_helper'

RSpec.describe UserController, type: :controller do

  subject { response }

  describe 'GET #new' do
    before { get :new }

    it { is_expected.to have_http_status(:success) }
  end

  describe 'GET #show' do
    let(:current_user) { create :user }

    before do
      expect(controller).to receive(:authorize).with(current_user)
      allow(controller).to receive(:verify_authorized)

      get :show, params: { id: view_user.id }
    end

    context 'when viewing their own user page' do
      let(:view_user) { current_user }

      it { is_expected.to have_http_status(:success) }
    end
  end
end
