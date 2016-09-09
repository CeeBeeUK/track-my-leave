require 'rails_helper'

RSpec.describe LeavePolicy, type: :policy do
  #
  # let(:leave) { create :leave }
  #
  # subject(:policy) { described_class.new(user, leave) }
  #
  # context 'for staff' do
  #   let(:user) { build_stubbed(:user) }
  #
  #   it { is_expected.not_to permit_action(:index) }
  #   it { is_expected.not_to permit_action(:new) }
  #   it { is_expected.not_to permit_action(:create) }
  #   it { is_expected.not_to permit_action(:edit) }
  #   it { is_expected.not_to permit_action(:update) }
  #
  #   context 'when the user belongs to the office' do
  #     let(:user) { build_stubbed(:staff, office: office) }
  #
  #     it { is_expected.to permit_action(:show) }
  #   end
  #
  #   context 'when the user does not belong to the office' do
  #     it { is_expected.not_to permit_action(:show) }
  #   end
  # end
end
