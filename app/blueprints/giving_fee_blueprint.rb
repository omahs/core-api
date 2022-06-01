class GivingFeeBlueprint < Blueprinter::Base
  fields :card_fee, :crypto_fee, :crypto_giving, :giving_total, :net_giving, :service_fees
end
