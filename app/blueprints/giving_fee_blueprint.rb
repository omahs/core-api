class GivingFeeBlueprint < Blueprinter::Base
  fields %i[card_fee crypto_fee crypto_giving giving_total net_giving service_fees]
end
