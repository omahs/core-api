# == Schema Information
#
# Table name: contributions
#
#  id                :bigint           not null, primary key
#  receiver_type     :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  person_payment_id :bigint           not null
#  receiver_id       :bigint           not null
#
FactoryBot.define do
  factory :contribution do
    person_payment { build(:person_payment) }
    receiver { build(:non_profit) }
  end
end
