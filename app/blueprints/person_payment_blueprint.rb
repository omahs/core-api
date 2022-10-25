class PersonPaymentBlueprint < Blueprinter::Base
  identifier :id

  fields :paid_date, :crypto_amount, :amount_cents, :payment_method, :status, :external_id

  field :total_items do |_, options|
    options[:total_items]
  end

  field :page do |_, options|
    options[:page]
  end

  field :total_pages do |_, options|
    options[:total_pages]
  end

  association :offer, blueprint: OfferBlueprint
  association :person, blueprint: PersonBlueprint
end
