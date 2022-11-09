# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string
#  last_donated_cause :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :user do
    sequence :email, 100 do |n|
      "user#{n}@example.com"
    end
  end
end
