class PersonPaymentFee < ApplicationRecord
  belongs_to :person_payment

  def service_fee_cents
    card_fee_cents + crypto_fee_cents
  end

  def card_fee
    card_fee_cents / 100.0
  end

  def crypto_fee
    crypto_fee_cents / 100.0
  end

  def service_fee
    service_fee_cents / 100.0
  end
end
