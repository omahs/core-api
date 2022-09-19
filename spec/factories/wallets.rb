# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  address    :string
#  owner_type :string           not null
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
FactoryBot.define do
  factory :wallet do
    address { "MyString" }
    status { 1 }
    owner { nil }
  end
end
