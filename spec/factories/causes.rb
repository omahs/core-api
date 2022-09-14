# == Schema Information
#
# Table name: causes
#
#  id      :bigint           not null, primary key
#  name    :string
#  pool_id :bigint           not null
#
FactoryBot.define do
  factory :cause do
    name { 'Cause' }
    pool { build(:pool) }
  end
end
