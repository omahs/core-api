class UserImpactBlueprint < Blueprinter::Base
  fields :impact
  association :non_profit, blueprint: NonProfitBlueprint
end
