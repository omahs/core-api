FactoryBot.define do
  factory :offer do
    currency { 0 }
    subscription { 0 }
    price_cents { 1 }
    active { false }
    title { "Super oferta de fim de ano" }
    position_order { 1 }
    offer_gateway { build(:offer_gateway) }
  end
end
