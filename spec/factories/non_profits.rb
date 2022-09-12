FactoryBot.define do
  factory :non_profit do
    name { 'Evidence Action' }
    status { :active }
    wallet_address { '0x6E060041D62fDd76cF27c582f62983b864878E8F' }
    impact_description { '1 day of water' }

    trait(:with_impact) do
      after(:create) do |non_profit|
        non_profit.non_profit_impacts
                  .create(usd_cents_to_one_impact_unit: 10,
                          start_date: 1.year.ago, end_date: 1.year.from_now)
      end
    end
  end
end
