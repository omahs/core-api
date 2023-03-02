# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  level      :integer          default(0)
#  language   :integer          default("en")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sash_id    :integer
#
FactoryBot.define do
  factory :user do
    sequence :email, 100 do |n|
      "user#{n}@example.com"
    end
  end
end
