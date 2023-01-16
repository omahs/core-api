# == Schema Information
#
# Table name: non_profits
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :integer          default("inactive")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cause_id   :bigint
#
FactoryBot.define do
  factory :non_profit do
    name { 'Evidence Action' }
    status { :active }
    wallet_address { '0x6E060041D62fDd76cF27c582f62983b864878E8F' }
    cause { build(:cause) }

    trait(:with_impact) do
      after(:create) do |non_profit|
        non_profit.non_profit_impacts
                  .create(usd_cents_to_one_impact_unit: 10, impact_description_en: "1 day of water", impact_description_pt_br: "1 dia de água",
                          start_date: 1.year.ago, end_date: 1.year.from_now)
      end
    end
  end
end
