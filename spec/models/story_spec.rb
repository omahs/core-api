require 'rails_helper'

RSpec.describe Story, type: :model do
  describe '.validations' do
    subject { build(:story) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_presence_of(:active) }
    it { is_expected.to belong_to(:non_profit) }
  end
end
