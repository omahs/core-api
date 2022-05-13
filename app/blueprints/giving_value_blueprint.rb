class GivingValueBlueprint < Blueprinter::Base
  identifier :id

  fields :updated_at, :created_at, :value, :currency

  field(:value_text) do |object|
    "#{object.currency_symbol}#{object.value}"
  end
end
