require 'rails_helper'

RSpec.describe PersonBlockchainTransaction, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:person_payment) }
    it { is_expected.to define_enum_for(:treasure_entry_status).with_values(%i[processing success failed]) }
  end
end
