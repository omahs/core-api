module Payment
  module Gateways
    module Stripe
      module Entities
        class TaxId
          def self.add_to_customer(stripe_customer:, national_id:)
            ::Stripe::Customer.create_tax_id(
              stripe_customer&.id,
              {
                type: Base::ALLOWED_TAXID_TYPES[:brazil][:cpf],
                value: national_id
              }
            )
          end
        end
      end
    end
  end
end
