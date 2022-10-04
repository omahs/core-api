# == Schema Information
#
# Table name: donations
#
#  id             :bigint           not null, primary key
#  value          :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  integration_id :bigint           not null
#  non_profit_id  :bigint           not null
#  user_id        :bigint
#
class Donation < ApplicationRecord
  belongs_to :non_profit
  belongs_to :integration
  belongs_to :user

  has_one :donation_blockchain_transaction

  def impact
    "#{impact_value} #{non_profit.impact_description}"
  end

  def impact_value
    (value / non_profit.impact_for.usd_cents_to_one_impact_unit).to_i
  rescue StandardError
    0
  end
end
