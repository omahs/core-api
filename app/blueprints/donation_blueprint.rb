class DonationBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :value

  association :non_profit, blueprint: NonProfitBlueprint
  association :integration, blueprint: IntegrationBlueprint

  view :integrations do
    excludes :integration
  end
end
