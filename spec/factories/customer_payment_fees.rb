FactoryBot.define do
  factory :customer_payment_fee do
    card_fee_cents { 1 }
    crypto_fee_cents { 1 }
    customer_payment { nil }
  end
end
