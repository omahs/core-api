# == Schema Information
#
# Table name: batches
#
#  id         :bigint           not null, primary key
#  cid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :batch do
    cid { 'cid' }
    # donations { create_list(:donation, 2) }
  end
end
