class LegacyUserContributionsBlueprint < Blueprinter::Base
  fields :user_id, :value, :day, :legacy_payment_id, :legacy_payment_platform,
         :legacy_payment_method, :from_subscription, :created_at, :updated_at

  association :user, blueprint: UserBlueprint
end
