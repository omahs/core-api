# == Schema Information
#
# Table name: histories
#
#  id              :bigint           not null, primary key
#  total_donations :bigint
#  total_donors    :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :history do
    total_donors { 1010 }
    total_donations { 1010 }
  end
end
