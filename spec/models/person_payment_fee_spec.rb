# == Schema Information
#
# Table name: person_payment_fees
#
#  id                :bigint           not null, primary key
#  card_fee_cents    :integer
#  crypto_fee_cents  :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  person_payment_id :bigint           not null
#
# Indexes
#
#  index_person_payment_fees_on_person_payment_id  (person_payment_id)
#
# Foreign Keys
#
#  fk_rails_...  (person_payment_id => person_payments.id)
#
require 'rails_helper'

RSpec.describe PersonPaymentFee, type: :model do
  subject(:person_payment_fee) { build(:person_payment_fee, card_fee_cents: 100, crypto_fee_cents: 150) }

  describe 'validations' do
    it { is_expected.to belong_to(:person_payment) }
  end

  describe '#service_fee_cents' do
    it 'returns the sum of card_fee and crypto_fee' do
      expect(person_payment_fee.service_fee_cents).to eq 250
    end
  end

  describe '#service_fee' do
    it 'returns the service fee total amount' do
      expect(person_payment_fee.service_fee).to eq 2.50
    end
  end

  describe '#card_fee' do
    it 'returns the card fee total amount' do
      expect(person_payment_fee.card_fee).to eq 1.0
    end
  end

  describe '#crypto_fee' do
    it 'returns the crypto fee total amount' do
      expect(person_payment_fee.crypto_fee).to eq 1.5
    end
  end
end
