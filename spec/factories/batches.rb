# == Schema Information
#
# Table name: batches
#
#  id         :bigint           not null, primary key
#  amount     :decimal(, )
#  cid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :batch do
    cid { 'cid' }
    amount { 100 }
  end
end
