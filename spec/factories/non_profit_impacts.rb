# == Schema Information
#
# Table name: non_profit_impacts
#
#  id                           :bigint           not null, primary key
#  end_date                     :date
#  start_date                   :date
#  usd_cents_to_one_impact_unit :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  non_profit_id                :bigint           not null
#
# Indexes
#
#  index_non_profit_impacts_on_non_profit_id  (non_profit_id)
#
# Foreign Keys
#
#  fk_rails_...  (non_profit_id => non_profits.id)
#
FactoryBot.define do
  factory :non_profit_impact do
    non_profit { nil }
    start_date { '2022-02-02' }
    end_date { '2022-02-02' }
    usd_cents_to_one_impact_unit { 1 }
  end
end
