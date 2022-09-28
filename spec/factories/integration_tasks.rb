# == Schema Information
#
# Table name: integration_tasks
#
#  id             :bigint           not null, primary key
#  description    :string
#  link           :string
#  link_address   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#
FactoryBot.define do
  factory :integration_task do
    description { 'Realize outra compra' }
    link { 'Ganhe mais 1 vale' }
    link_address { 'https://renner.com' }
    integration_id { 1 }
  end
end
