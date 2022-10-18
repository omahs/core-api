class PersonPaymentBlueprint < Blueprinter::Base
  identifier :id
  fields :paid_date, :crypto_amount, :amount_cents, :payment_method, :status
  association :offer, blueprint: OfferBlueprint
  association :person, blueprint: PersonBlueprint
end
