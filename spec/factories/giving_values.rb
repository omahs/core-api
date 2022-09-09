# == Schema Information
#
# Table name: giving_values
#
#  id         :bigint           not null, primary key
#  currency   :integer          default("usd")
#  value      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :giving_value do
    value { '9.99' }
    currency { 1 }
  end
end
