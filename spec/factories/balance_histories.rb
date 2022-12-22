# == Schema Information
#
# Table name: balance_histories
#
#  id             :bigint           not null, primary key
#  amount_donated :decimal(, )
#  balance        :decimal(, )
#  date           :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cause_id       :bigint           not null
#  pool_id        :bigint           not null
#
FactoryBot.define do
  factory :balance_history do
    date { "2022-12-21" }
    cause { build(:cause) }
    pool { build(:pool) }
    balance { "9.99" }
    amount_donated { "9.99" }
  end
end
