# == Schema Information
#
# Table name: person_blockchain_transactions
#
#  id                    :bigint           not null, primary key
#  transaction_hash      :string
#  treasure_entry_status :integer          default("processing")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  person_payment_id     :bigint
#
require 'rails_helper'

RSpec.describe PersonBlockchainTransaction, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:person_payment) }
    it { is_expected.to define_enum_for(:treasure_entry_status).with_values(%i[processing success failed]) }
  end
end
