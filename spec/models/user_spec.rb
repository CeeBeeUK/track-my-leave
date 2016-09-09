require 'rails_helper'
include OmniAuthHelpers

RSpec.describe User, type: :model do

  let(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:uid) }
  end

  describe '#from_omniauth' do

  end
end
