# == Schema Information
#
# Table name: big_donors
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :big_donor do
    name { "Yang" }
    email { "ronaldo@gmail.com" }
  end
end
