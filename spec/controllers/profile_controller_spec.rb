require 'rails_helper'

RSpec.describe ProfileController, type: :controller do

  subject { response }

  describe 'GET #new' do
    before { get :new }

    it { is_expected.to have_http_status(:success) }
  end

  describe 'GET #show' do
    before { get :show }

    it { is_expected.to have_http_status(:success) }
  end
end
