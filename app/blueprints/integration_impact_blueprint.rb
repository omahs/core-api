class IntegrationImpactBlueprint < Blueprinter::Base
  fields :total_donations, :total_donors, :impact_per_non_profit

  field :impact_per_non_profit do |object|
    object[:impact_per_non_profit].map do |impact|
      { non_profit: NonProfitBlueprint
        .render_as_hash(impact[:non_profit], view: :no_cause), impact: impact[:impact] }
    end
  end
end
