require 'rails_helper'

RSpec.describe CustomerPaymentBlockchain, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:customer_payment) }
    it { is_expected.to define_enum_for(:treasure_entry_status).with(%i[processing success failed]) }
  end
end
