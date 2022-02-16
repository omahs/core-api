require 'rails_helper'

RSpec.describe Integration, type: :model do
  describe '.validations' do
    subject { build(:integration) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:wallet_address) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:logo) }
  end
end
