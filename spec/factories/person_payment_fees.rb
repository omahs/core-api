# == Schema Information
#
# Table name: person_payment_fees
#
#  id                :bigint           not null, primary key
#  card_fee_cents    :integer
#  crypto_fee_cents  :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  person_payment_id :bigint           not null
#
FactoryBot.define do
  factory :person_payment_fee do
    card_fee_cents { 100 }
    crypto_fee_cents { 100 }
    association :person_payment, factory: :person_payment
  end
end
