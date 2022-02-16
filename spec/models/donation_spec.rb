require 'rails_helper'

RSpec.describe Donation, type: :model do
  describe '.validations' do
    subject { build(:donation) }

    it { is_expected.to belong_to(:non_profit) }
    it { is_expected.to belong_to(:integration) }
  end
end
