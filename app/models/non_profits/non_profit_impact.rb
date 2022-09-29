# == Schema Information
#
# Table name: non_profit_impacts
#
#  id                           :bigint           not null, primary key
#  end_date                     :date
#  start_date                   :date
#  usd_cents_to_one_impact_unit :decimal(, )
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  non_profit_id                :bigint           not null
#
class NonProfitImpact < ApplicationRecord
  belongs_to :non_profit

  validates :usd_cents_to_one_impact_unit, :start_date, :end_date, presence: true

  def impact_by_ticket
    (RibonConfig.default_ticket_value / usd_cents_to_one_impact_unit).to_i
  rescue StandardError
    0
  end
end
