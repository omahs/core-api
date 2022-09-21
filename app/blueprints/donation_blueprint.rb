class DonationBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :value

  association :non_profit, blueprint: NonProfitBlueprint
  association :integration, blueprint: IntegrationBlueprint

  view :minimal do
    excludes :integration, :updated_at
  end
end
