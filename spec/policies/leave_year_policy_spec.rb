require 'rails_helper'

RSpec.describe LeaveYearPolicy, type: :policy do

  let(:user) { build_stubbed(:user) }
  let(:user2) { build_stubbed(:user) }

  subject(:policy) { described_class.new(user, leave_year) }

  context 'when the user views their own leave_year' do
    let(:leave_year) { create :leave_year, user: user }

    it { is_expected.to permit_action(:show) }
  end

  context 'when the user tries to view another users leave_year' do
    let(:leave_year) { create :leave_year, user: user2 }

    it { is_expected.not_to permit_action(:show) }
  end
end
