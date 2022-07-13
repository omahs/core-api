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
