require 'rails_helper'

RSpec.describe UserController, type: :controller do

  let(:current_user) { create :user }
  let(:different_user) { create :user }

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

  # describe 'PUT #update' do
  #   let(:existing_user) { current_user }
  #   let(:params) { valid_params }
  #
  #   before do
  #     allow(User).to receive(:find).with(existing_office.to_param.to_s).and_return(existing_office)
  #     mock_authorise(existing_office, authorised)
  #   end
  #
  #   subject { put :update, id: existing_office.id, office: params }
  #
  #   context 'when authorised' do
  #     let(:authorised) { true }
  #     let(:manager_setup) { double(setup_profile?: false, in_progress?: false) }
  #
  #     before do
  #       allow(existing_office).to receive(:errors).and_return(saved ? [] : [double, double])
  #       expect(existing_office).to receive(:save).and_return(saved)
  #       subject
  #     end
  #
  #     context 'when the office can be saved' do
  #       let(:saved) { true }
  #
  #       it 'sets a flash notice' do
  #         expect(flash[:notice]).to eql('Office was successfully updated')
  #       end
  #
  #       context 'when the user is a manager setting up a new office' do
  #         context 'when the manager needs to setup their profile' do
  #           let(:manager_setup) { double(setup_profile?: true, in_progress?: true) }
  #
  #           it 'redirects to the user edit profile page' do
  #             expect(response).to redirect_to(edit_user_path(user))
  #           end
  #         end
  #         context 'when the manager does not need to setup their profile' do
  #           let(:manager_setup) { double(setup_profile?: false, in_progress?: true) }
  #           it 'redirects to the home page' do
  #             expect(response).to redirect_to(root_path)
  #           end
  #         end
  #       end
  #
  #       context 'when the user is not a manager setting up a new office' do
  #         it 'redirects to the office show page' do
  #           expect(response).to redirect_to(office_path(existing_office))
  #         end
  #       end
  #     end
  #
  #     context 'when the office can not be saved' do
  #       let(:saved) { false }
  #
  #       it 'renders the new template' do
  #         expect(response).to render_template(:edit)
  #       end
  #
  #       it 'assigns the office' do
  #         expect(assigns(:office)).to eql(existing_office)
  #       end
  #     end
  #   end
  #
  #   include_examples 'when not authorised'
  # end

end
