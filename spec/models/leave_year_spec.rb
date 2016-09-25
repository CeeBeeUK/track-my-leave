require 'rails_helper'

RSpec.describe LeaveYear, type: :model do
  let(:leave_year) { build :leave_year }

  describe 'validations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to validate_presence_of :starts_on }
    it { is_expected.to validate_presence_of :entitlement }
    it { is_expected.to validate_presence_of :carried_forward }
  end

  describe '#current_for' do
    let!(:user) { create :user }

    subject { described_class.current_for(user) }

    context 'when passed a user with no leave year' do
      let!(:leave_year) { nil }
      it { is_expected.to eq leave_year }
    end

    context 'when passed a user with a leave year' do
      let!(:leave_year) { create :leave_year, user: user }
      it { is_expected.to eq leave_year }
    end

    context 'when passed a user with two leave years' do
      let!(:year_one) { create :leave_year, user: user, starts_on: '2010-01-01' }
      let!(:year_two) { create :leave_year, user: user, starts_on: '2011-01-01' }

      it { is_expected.to eq year_two }
    end
  end
end
