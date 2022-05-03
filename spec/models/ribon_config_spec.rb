require 'rails_helper'

RSpec.describe RibonConfig, type: :model do
  describe 'validations' do
    subject { build(:ribon_config) }

    it { is_expected.to validate_presence_of(:default_ticket_value) }
  end

  it 'acts like a singleton' do
    create(:ribon_config)

    expect { create(:ribon_config) }.to raise_error(StandardError)
  end
end
