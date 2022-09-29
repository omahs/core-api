class DonationBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :value

  association :non_profit, blueprint: NonProfitBlueprint
  association :user, blueprint: UserBlueprint
  association :integration, blueprint: IntegrationBlueprint
end
