require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:accessing_user) { build_stubbed(:user) }

  subject(:policy) { described_class.new(accessing_user, subject_user) }

  context 'when the user views their own user' do
    let(:subject_user) { accessing_user }
    it { is_expected.to permit_action(:show) }
  end

  context 'when the user tries to view another users user' do
    let(:subject_user) { build_stubbed(:user) }

    it { is_expected.not_to permit_action(:show) }
  end
end
