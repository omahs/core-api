class NonProfitImpact < ApplicationRecord
  belongs_to :non_profit

  validates :usd_cents_to_one_impact_unit, :start_date, :end_date, presence: true
end
