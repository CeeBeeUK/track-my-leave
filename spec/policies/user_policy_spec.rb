require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:accessing_user) { build_stubbed(:user) }

  subject(:policy) { described_class.new(accessing_user, subject_user) }

  context 'on their own account' do
    let(:subject_user) { accessing_user }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:edit) }
  end

  context 'on someone else`s account' do
    let(:subject_user) { build_stubbed(:user) }

    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:edit) }
  end
end
