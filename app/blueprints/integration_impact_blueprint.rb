class IntegrationImpactBlueprint < Blueprinter::Base
  fields :total_donations, :total_donors, :impact_per_non_profit,
         :previous_total_donations, :previous_total_donors, :previous_impact_per_non_profit,
         :total_donations_balance, :total_donors_balance, :total_donations_trend,
         :total_donors_trend

  field :impact_per_non_profit do |object|
    object[:impact_per_non_profit].map do |impact|
      { non_profit: NonProfitBlueprint
        .render_as_hash(impact[:non_profit], view: :no_cause), impact: impact[:impact] }
    end
  end
end
