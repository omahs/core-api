class CustomerPaymentBlueprint < Blueprinter::Base
  identifier :id
  fields :paid_date, :crypto_amount
  association :offer, blueprint: OfferBlueprint
end
