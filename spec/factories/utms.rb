# == Schema Information
#
# Table name: utms
#
#  id             :bigint           not null, primary key
#  campaign       :string
#  medium         :string
#  source         :string
#  trackable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  trackable_id   :bigint
#
FactoryBot.define do
  factory :utm do
    source { 'Source' }
    medium { 'Medium' }
    campaign { 'Campaign' }
    trackable { nil }
  end
end
