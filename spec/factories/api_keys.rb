# == Schema Information
#
# Table name: api_keys
#
#  id           :bigint           not null, primary key
#  bearer_type  :string           not null
#  token_digest :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  bearer_id    :bigint           not null
#
FactoryBot.define do
  factory :api_key do
    bearer { nil }
    token_digest { 'MyString' }
  end
end
