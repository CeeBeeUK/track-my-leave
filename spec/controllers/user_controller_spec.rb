require 'rails_helper'

RSpec.describe UserController, type: :controller do

  let(:current_user) { create :user }
  let(:different_user) { create :user }
  let(:valid_params) { attributes_for(:user).merge(name: 'foo') }

  subject { response }

  def mock_authorise(record, authorised)
    expectation = receive(:authorize).with(record)
    expectation.and_raise(Pundit::NotAuthorizedError) unless authorised

    expect(controller).to expectation
    expect(controller).to receive(:verify_authorized) if authorised
  end

  shared_examples 'when not authorised' do
    context 'when not authorised' do
      let(:authorised) { false }

      it 'raises Pundit error' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'GET #show' do
    before do
      bypass_rescue
      mock_authorise(view_user, authorised)
    end

    subject { get :show, params: { id: view_user.id } }

    context 'when viewing their own user page' do
      let(:view_user) { current_user }
      let(:authorised) { true }

      it { is_expected.to have_http_status(:success) }
    end

    context 'for a different user' do
      let(:view_user) { different_user }

      include_examples 'when not authorised'
    end
  end

  describe 'GET #edit' do
    before do
      bypass_rescue
      mock_authorise(view_user, authorised)
    end

    subject { get :edit, params: { id: view_user.id } }

    context 'when viewing their own user page' do
      let(:view_user) { current_user }
      let(:authorised) { true }

      it { is_expected.to have_http_status(:success) }
    end

    context 'for a different user' do
      let(:view_user) { different_user }

      include_examples 'when not authorised'
    end
  end

  describe 'PUT #update' do
    let(:amend_user) { current_user }
    let(:params) { valid_params }

    before do
      allow(User).to receive(:find).with(amend_user.to_param.to_s).and_return(amend_user)
      bypass_rescue
      mock_authorise(amend_user, authorised)
    end

    subject { put :update, params: { id: amend_user.id, user: params } }

    context 'when authorised' do
      let(:authorised) { true }

      context 'when params are valid' do
        it { is_expected.to have_http_status(:redirect) }
      end

      context 'when params are invalid' do
        let(:params) { attributes_for(:user).merge(name: nil) }
        it { is_expected.to have_http_status(:success) }
      end
    end

    context 'for a different user' do
      let(:amend_user) { different_user }

      include_examples 'when not authorised'
    end
  end
end
