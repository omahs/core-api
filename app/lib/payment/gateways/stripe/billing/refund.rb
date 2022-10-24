module Payment
  module Gateways
    module Stripe
      module Billing
        class Refund
          def self.create(external_id:)
            ::Stripe::Refund.create({
                                      payment_intent: external_id
                                    })
          end
        end
      end
    end
  end
end
