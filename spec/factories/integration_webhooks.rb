# == Schema Information
#
# Table name: integration_webhooks
#
#  id             :bigint           not null, primary key
#  url            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#
FactoryBot.define do
  factory :integration_webhook do
    integration { nil }
    url { 'MyString' }
  end
end
