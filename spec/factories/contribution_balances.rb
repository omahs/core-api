# == Schema Information
#
# Table name: contribution_balances
#
#  id                                  :bigint           not null, primary key
#  contribution_increased_amount_cents :integer
#  fees_balance_cents                  :integer
#  tickets_balance_cents               :integer
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  contribution_id                     :bigint           not null
#
FactoryBot.define do
  factory :contribution_balance do
    contribution { build(:contribution) }
    tickets_balance_cents { 100 }
    fees_balance_cents { 100 }
    contribution_increased_amount_cents { 100 }
  end
end
