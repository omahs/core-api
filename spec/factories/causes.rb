# == Schema Information
#
# Table name: causes
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pool_id    :bigint           not null
#
FactoryBot.define do
  factory :cause do
    name { 'Cause' }
    pool_id { 1 }
  end
end
