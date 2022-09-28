# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  level      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sash_id    :integer
#
FactoryBot.define do
  factory :user do
    email { 'user@gmail.com' }
  end
end
