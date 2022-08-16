class NonProfitImpact < ApplicationRecord
  belongs_to :non_profit

  validates :usd_cents_to_one_impact_unit, :start_date, :end_date, presence: true

  def impact_by_ticket
    RibonConfig.default_ticket_value.to_f / usd_cents_to_one_impact_unit
  rescue StandardError
    0
  end
end
