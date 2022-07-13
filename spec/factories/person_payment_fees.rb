FactoryBot.define do
  factory :person_payment_fee do
    card_fee_cents { 100 }
    crypto_fee_cents { 100 }
    association :person_payment, factory: :person_payment
  end
end
