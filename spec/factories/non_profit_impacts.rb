FactoryBot.define do
  factory :non_profit_impact do
    non_profit { nil }
    start_date { '2022-02-02' }
    end_date { '2022-02-02' }
    usd_cents_to_one_impact_unit { 1 }
  end
end
