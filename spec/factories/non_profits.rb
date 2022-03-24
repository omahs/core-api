FactoryBot.define do
  factory :non_profit do
    name { 'Evidence Action' }
    wallet_address { '0x000' }
    impact_description { 'Days of water' }
    link { 'https://evidenceaction.org' }

    trait(:with_impact) do
      after(:create) do |non_profit|
        non_profit.non_profit_impacts
                  .create(usd_cents_to_one_impact_unit: 100,
                          start_date: 1.year.ago, end_date: 1.year.from_now)
      end
    end
  end
end
