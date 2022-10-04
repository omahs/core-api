# == Schema Information
#
# Table name: badges
#
#  id             :bigint           not null, primary key
#  category       :integer
#  description    :text
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  merit_badge_id :integer
#
FactoryBot.define do
  factory :badge do
    description { 'MyText' }
    category { 1 }
    merit_badge_id { 1 }
    name { 'MyString' }
  end
end
