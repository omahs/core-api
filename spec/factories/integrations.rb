# == Schema Information
#
# Table name: integrations
#
#  id                             :bigint           not null, primary key
#  name                           :string
#  status                         :integer          default("inactive")
#  ticket_availability_in_minutes :integer
#  unique_address                 :uuid             not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
FactoryBot.define do
  factory :integration do
    name { 'Renner' }
    status { :active }
    unique_address { 'f7be8d80-2406-4cb0-82eb-849346d327c9' }
    ticket_availability_in_minutes { nil }
    new_integration_wallet { build(:new_integration_wallet) }
  end
end
