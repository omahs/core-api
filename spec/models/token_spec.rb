require 'rails_helper'

RSpec.describe Token, type: :model do
  describe '.validations' do
    subject { build(:token) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:decimals) }
    it { is_expected.to belong_to(:chain) }
  end
end
