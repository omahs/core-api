FactoryBot.define do
  factory :person_payment_fee do
    card_fee_cents { 1 }
    crypto_fee_cents { 1 }
    person_payment { nil }
  end
end
