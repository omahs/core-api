FactoryBot.define do
  factory :offer do
    currency { 0 }
    recurrence { 0 }
    price_cents { 1 }
    active { false }
    title { "Super oferta de fim de ano" }
    position_order { 1 }
    bundle { build(:bundle) }
    offer_gateway { build(:offer_gateway) }
  end
end
