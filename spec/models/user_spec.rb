require 'rails_helper'
include OmniAuthHelpers

RSpec.describe User, type: :model do

  let(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:uid) }

    describe 'start_month' do
      before { user.start_month = start_month }

      subject { user }

      context 'when start_month is nil' do
        let(:start_month) { nil }

        it { is_expected.to be_invalid }
      end

      (1..12).each do |month|
        context "when start_month is #{month}" do
          let(:start_month) { month }

          it { is_expected.to be_valid }
        end
      end

      %w[0 13 foo].each do |month|
        context "when start_month is #{month}" do
          let(:start_month) { month }

          it { is_expected.to be_invalid }
        end
      end
    end

    describe 'start_day' do
      before { user.start_day = start_day }

      subject { user }

      context 'when start_day is nil' do
        let(:start_day) { nil }

        it { is_expected.to be_invalid }
      end

      (1..31).each do |day|
        context "when start_day is #{day}" do
          let(:start_day) { day }

          it { is_expected.to be_valid }
        end
      end

      %w[0 32 foo].each do |day|
        context "when start_day is #{day}" do
          let(:start_day) { day }

          it { is_expected.to be_invalid }
        end
      end
    end
  end

  describe '.from_omniauth' do

  end

  describe '#leave_year_starts' do
    subject { user.leave_year_starts }

    it { is_expected.to eql 'January 1st' }
  end
end
